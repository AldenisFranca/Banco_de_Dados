-- Consultas em SQL


-- 1. Quais comandos apagam somente os dados da tabela MATERIAIS_FORNECIDOS e remove esta tabela do banco de dados?

DELETE FROM MATERIAIS_FORNECIDOS;
DROP TABLE MATERIAIS_FORNECIDOS;


-- 2. Qual comando apaga a coluna NOME da tabela CARGOS?

ALTER TABLE CARGOS DROP COLUMN nome;


-- 3. Quais comandos atualizam a tabela CARGOS para adicionar a coluna salario_base como DECIMAL(7,2), além de adicionar as informações de que o salário-base de um Engenheiro civil é R$5237.92, o de um Eletricista é R$2365.22 e o de um Motorista é R$1788.16?

ALTER TABLE CARGOS ADD salario_base DECIMAL(7,2);
UPDATE CARGOS set salario_base = 5237.92 WHERE nome = 'Engenheiro civil';
UPDATE CARGOS set salario_base = 2365.22 WHERE nome = 'Eletricista';
UPDATE CARGOS set salario_base = 1788.16 WHERE nome = 'Motorista';


-- 4. Quais os nomes e os anos das construtoras fundadas nos anos 80?

SELECT nome_fantasia, ano_fundacao FROM CONSTRUTORA WHERE ano_fundacao BETWEEN '1980' and '1989';


-- 5. Quais os nomes e matrículas dos funcionários que recebem mais de 4000 de salário e têm mais de 30 anos?

SELECT nome_completo, matricula FROM FUNCIONARIOS WHERE salario > 4000.00 and data_nascimento < '1992-01-25';
                
                        
-- 6. Quais funcionários não são pais?

SELECT nome_completo FROM FUNCIONARIOS WHERE qtd_filhos = 0 and sexo = 'M';


-- 7. Quantos funcionários não tem telefone cadastrado?

SELECT COUNT(*) as 'Qtde. Funcionários' FROM FUNCIONARIOS WHERE matricula not in 
(SELECT DISTINCT matr_funcionario from TELEFONES_FUNCIONARIOS);


-- 8. Quantos cargos não possuem descrição?

SELECT COUNT(*) as 'Qtde. Cargos' FROM CARGOS WHERE descricao is NULL;


-- 9. Quais os nomes e CNPJ dos fornecedores que são Sociedade Limitada, ou seja, LTDA.? Ordene-os pela matrícula.

SELECT razao_social, cnpj FROM FORNECEDORES WHERE razao_social LIKE '%ltda.%' ORDER BY matricula;


-- 10. Qual o nome do funcionário mais novo e em qual construtora ele(a) trabalha?

SELECT F.nome_completo, C.nome_fantasia FROM FUNCIONARIOS F, CONSTRUTORA C
WHERE F.data_nascimento = (SELECT max(data_nascimento) FROM FUNCIONARIOS) 
and C.id = F.id_construtora;


-- 11. Qual a média salarial da construtora Bragança Lopes?

SELECT AVG(salario) as 'Média Salarial' FROM FUNCIONARIOS WHERE id_construtora =
 (SELECT id FROM CONSTRUTORA WHERE nome_fantasia = 'Bragança Lopes');
 
 
-- 12. Quais construtoras possuem pelo menos 2 funcionários cadastrados? Exiba as colunas como 'Construtora' e 'Qtde. Funcionários'.

SELECT C.nome_fantasia as 'Construtora', COUNT(F.cpf) as 'Qtde. Funcionários' from FUNCIONARIOS F, CONSTRUTORA C 
WHERE F.id_construtora = C.id group by C.nome_fantasia HAVING COUNT(F.cpf) >= 2;


-- 13. Informe a razão social de 5 construtoras que não são Sociedade Limitada, ou seja, não são LTDA.

SELECT razao_social FROM CONSTRUTORA WHERE razao_social not LIKE '%ltda.%' LIMIT 5;


-- 14. Quais os nomes e CPFs dos funcionários que recebem no máximo R$ 3000.00, que não estão na faixa etária de 20 a 30 anos, nem têm a letra S no nome do seu cargo? Apresente os dados ordenados descrescentemente por salário.

SELECT nome_completo, cpf FROM FUNCIONARIOS WHERE salario <= 3000.00 and data_nascimento 
NOT BETWEEN '1992-01-25' and '2002-01-25' and cbo_cargos in (SELECT cbo FROM CARGOS WHERE nome not like '%s%') ORDER BY salario DESC;
 

-- 15. Qual(ou quais) o(s) id(s) e nome(s) fantasia da(s) construtora(s) não tem funcionário e nem telefone cadastrado?
SELECT id, nome_fantasia as 'Nome Fantasia' FROM CONSTRUTORA WHERE id not in ( 
SELECT DISTINCT FUNCIONARIOS.id_construtora 
FROM FUNCIONARIOS left OUTER join TELEFONES_CONSTRUTORA on FUNCIONARIOS.id_construtora = TELEFONES_CONSTRUTORA.id_construtora
UNION
SELECT DISTINCT TELEFONES_CONSTRUTORA.id_construtora
FROM TELEFONES_CONSTRUTORA left OUTER join FUNCIONARIOS on FUNCIONARIOS.id_construtora = TELEFONES_CONSTRUTORA.id_construtora 
  RIGHT JOIN CONSTRUTORA ON (CONSTRUTORA.id != FUNCIONARIOS.id_construtora OR 
                             CONSTRUTORA.id != TELEFONES_CONSTRUTORA.id_construtora));           
                             
                             
-- 16. Quais os nomes das construtoras que utilizaram materiais fornecidos pelas empresas fornecedoras e quanto elas pagaram a cada fornecedor? Exiba-as ordenadas pelo nome fantasia.

SELECT C.nome_fantasia, SUM(MF.valor) from CONSTRUTORA C INNER JOIN MATERIAIS_FORNECIDOS MF 
ON C.id = MF.id_construtora AND matr_fornecedor IN (SELECT matr_fornecedor FROM POSSUI)
GROUP BY 1 ORDER BY 1;


-- 17. Quais cidades do Nordeste do país possuem construtoras? Agrupe-as por estado e exiba-os.

SELECT cidade, estado FROM CONSTRUTORA WHERE estado in ('AL','BA','PE','PB','PI','CE','MA','SE','RN') GROUP BY estado;


-- 18. Quantos funcionários trabalham em cada construtora citada?

SELECT CONSTRUTORA.nome_fantasia, COUNT(FUNCIONARIOS.matricula) as 'Qtde. Funcionários' FROM FUNCIONARIOS, CONSTRUTORA 
WHERE CONSTRUTORA.id = FUNCIONARIOS.id_construtora GROUP BY CONSTRUTORA.nome_fantasia;


-- 19. Qual o nome e a idade da construtora mais antiga?

SELECT nome_fantasia, (2022-ano_fundacao) as 'idade' FROM CONSTRUTORA WHERE ano_fundacao = 
(SELECT MIN(ano_fundacao) FROM CONSTRUTORA);


-- 20. Que funcionário supervisiona o(a) estagiário(a)?

SELECT nome_completo FROM FUNCIONARIOS WHERE matricula in (SELECT matr_supervisiona FROM FUNCIONARIOS WHERE cbo_cargos in 
(SELECT cbo FROM CARGOS WHERE nome = 'Estagiário'));


-- 21. Quais os nomes e CNPJs dos fornecedores que têm material cadastrado e não são Sociedade Anônima, ou seja, não são S.A.?

SELECT razao_social,cnpj FROM FORNECEDORES WHERE material_fornecido IS NOT NULL AND 
razao_social NOT LIKE '%S.A%';


-- 22. Qual o custo total que a construtora Construtudo tem na compra de materiais?

SELECT sum(valor) as 'Custo Total' FROM MATERIAIS_FORNECIDOS WHERE id_construtora = 
(SELECT id FROM CONSTRUTORA WHERE nome_fantasia = 'Construtudo');                               
