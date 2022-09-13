CREATE TABLE area ( 
	codigo int primary key ,
	descricao varchar (30),
	predio varchar (40)
);
CREATE TABLE curso (
	codigo int primary key ,
	nome varchar (40) not null,
	cod_area int,
	vagas integer,
	nome_coordenador varchar(50),
	foreign key (cod_area) 
                     references area (codigo)	
);

CREATE TABLE aluno (
	matricula int primary key ,
	nome varchar (50) not null,
	cidade_endereco varchar (30),
	telefone int,
	mensalidade decimal (6,2),
	media_notas decimal (3,1) not null,
	data_nascimento date,
	cod_curso int not null,
	foreign key (cod_curso) 
	       references curso (codigo)
);

insert into area values
  (1,"Exatas", "Bloco C"), (2,"Saúde", "Bloco B"),
  (3,"Humanas", "Bloco A");

insert into curso values
  (1,"Informatica para Internet", 1, 20, "Francisco"),
  (2,"Nutrição", 2, 25, null),
  (3,"Enfermagem", 2, 30, "Maria"),
  (4,"Ciências da Computação", 1, 30, null),
  (5,"Redes de Computadores", 1, 20, "Zilmara"),
  (6,'Odontologia', null, 18, null);

INSERT INTO aluno  values
  (1,"Mariana Torres", "Recife",   null, 815.78, 8.9, '1998-10-19', 1), 
  (2,"Carolina Pereira", "Olinda", 982736410, 726.37, 7.5, null, 1), 
  (3,"Adriano Freire", "Palmares", NUll, 982.62, 5.2, '1994-07-05', 5), 
  (4,"Elaine Villas", "Olinda",    902816253, 856.01, 5.8, '2000-04-29', 3),
  (5,"Paulo Veras", "Olinda", 976253123, 582.71, 6.3, '1988-03-30', 3),
  (6,"Talita Veiga", "Jaboatão", 952434172, 837.29, 8.7, '1990-11-23', 4), 
  (7,"Katia Garcia", "Palmares", 962534122, 526.62, 9.7, '1991-10-19', 5), 
  (8,"Júlio Mercedes", "Palmares", null, 837.73, 7.6, null, 3), 
  (9,"Fátima Silva", "Jaboatão",   981722639, 549.91, 9.4, '1986-09-04', 5);

-- 1) Exibir a quantidade de cursos que cada área tem. Áreas sem cursos relacionados devem aparecer com 0.
SELECT area.descricao, COUNT(curso.nome) FROM area LEFT JOIN curso 
on area.codigo = curso.cod_area GROUP by area.descricao;

-- 7) Qual o valor total arrecadado pelas mensalidades?
SELECT sum(mensalidade) as 'Total Arrecadado' from aluno;

-- 6) Qual a maior e a menor mensalidade paga por curso?
SELECT curso.nome,max(mensalidade) as 'MAIOR', max(mensalidade) as 'MENOR' 
from aluno RIGHT JOIN curso ON curso.codigo = aluno.cod_curso
GROUP BY curso.nome;

-- 5) Qual a média das mensalidades pagas em cada curso? Cursos sem alunos devem exibir 0.
SELECT curso.nome, IFNULL(AVG(mensalidade),0) as 'MÉDIA'
from aluno RIGHT JOIN curso ON curso.codigo = aluno.cod_curso
GROUP BY curso.nome;

-- 9) Quantos alunos tem o curso de Redes de Computadores?
SELECT COUNT(*) as 'Qtde. Alunos' FROM aluno WHERE cod_curso = 
(SELECT codigo FROM curso WHERE nome = 'Redes de computadores');
-- ou
SELECT COUNT(*) as 'Qtde. Alunos' FROM aluno join curso on cod_curso = codigo
WHERE curso.nome = 'Redes de computadores';

-- 12) Qual a quantidade de vagas, de alunos matriculados e vagas disponíveis que existem em cada curso?
SELECT c.nome, c.vagas, COUNT(a.matricula) as 'Matriculados', vagas-COUNT(a.matricula) as 'Vagas Restantes'
FROM curso c LEFT JOIN aluno a on cod_curso = codigo
GROUP by c.nome, c.vagas;

-- 15) Em quais prédios acontecem as aulas de pelo menos 3 cursos?
SELECT predio 
from area JOIN curso on (area.codigo=curso.cod_area)
GROUP by predio 
HAVING COUNT(*) >= 3;

-- 19) Relacionar os nomes das áreas, dos cursos, e dos coordenadores ordenados pelo nome da área e depois pelo nome do curso. Devem aparecer cursos sem área e área sem cursos, caso existam.
(SELECT area.descricao, curso.nome, nome_coordenador 
FROM area LEFT JOIN curso on area.codigo = curso.cod_area
UNION
SELECT area.descricao, curso.nome, nome_coordenador 
FROM area RIGHT JOIN curso on area.codigo = curso.cod_area)
ORDER by 1,2

-- 2) Exibir a relação de nomes da área, do curso e dos alunos, além das médias, ordenados decrescentemente pela média.
SELECT a.descricao, c.nome, al.nome, al.media_notas 
FROM area a LEFT JOIN curso c on a.codigo = c.cod_area
LEFT JOIN aluno al on al.cod_curso = c.codigo
ORDER by media_notas DESC;

-- 3) Apresentar a lista de nomes dos cursos e de seus alunos ordenados pelo nome do curso e depois pelo nome dos alunos. Os cursos que não tiverem alunos matriculados devem aparecer acompanhados de null.
SELECT c.nome, al.nome
FROM curso c
LEFT JOIN aluno al on al.cod_curso = c.codigo
ORDER by 1,2;

-- 4) Para cada área, deve exibir o nome e a quantidade de alunos matriculados em cursos dessa área.
SELECT a.descricao, COUNT(al.nome)
FROM area a left JOIN curso c on a.codigo = c.cod_area
left JOIN aluno al on al.cod_curso = c.codigo
GROUP by a.codigo;

