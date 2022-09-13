/* IFPE - Campus Jaboatão
Dupla: Aldenis Everton Alves Guilherme de França e Leonardo da Rocha França
Turma: Análise e Desenvolvimento de Sistemas - Noite
Professora: Carolina Torres
Disciplina: Banco de Dados 2 
Projeto PLPGSQL */


-- Criação das Tabelas

CREATE TABLE CONSTRUTORA (
	id INTEGER PRIMARY KEY,
	cnpj BIGINT UNIQUE NOT NULL,
  	razao_social VARCHAR(30) NOT NULL,
	nome_fantasia VARCHAR(30) NOT NULL,
  	ano_fundacao INTEGER NOT NULL,
  	cep INTEGER NOT NULL,
    	rua VARCHAR(30),
    	numero INTEGER NOT NULL,
    	bairro VARCHAR(20),
    	cidade VARCHAR(20),
    	estado VARCHAR(2)
);

CREATE TABLE CARGOS (
	cbo INTEGER PRIMARY KEY,
    	nome VARCHAR(30) NOT NULL,
    	descricao VARCHAR(30)
);

CREATE TABLE FORNECEDORES (
	cnpj BIGINT UNIQUE NOT NULL,
  	razao_social VARCHAR(30) NOT NULL,
  	matricula INTEGER PRIMARY KEY,
  	material_fornecido VARCHAR(30)
);

CREATE TABLE FUNCIONARIOS (
	nome_completo VARCHAR(50) NOT NULL,	
    	rg INTEGER UNIQUE NOT NULL,
	cpf BIGINT UNIQUE NOT NULL,
    	salario DECIMAL(7,2) NOT NULL,
    	data_nascimento DATE NOT NULL,
    	sexo VARCHAR(1) NOT NULL,
	matricula INTEGER PRIMARY KEY,
	qtd_filhos INTEGER NOT NULL,
	id_construtora INTEGER NOT NULL,
  	FOREIGN KEY (id_construtora) REFERENCES CONSTRUTORA (id),
    	cbo_cargos INTEGER NOT NULL,
  	FOREIGN KEY (cbo_cargos) REFERENCES CARGOS (cbo),
    	matr_supervisiona INTEGER,	
  	FOREIGN KEY (matr_supervisiona) REFERENCES FUNCIONARIOS (matricula)
);

CREATE TABLE TELEFONES_CONSTRUTORA (
	id_construtora INTEGER NOT NULL, 
  	FOREIGN KEY (id_construtora) REFERENCES CONSTRUTORA (id),
	num_telefone BIGINT NOT NULL,
	PRIMARY KEY (id_construtora, num_telefone)
);

CREATE TABLE TELEFONES_FUNCIONARIOS (
	matr_funcionario INTEGER NOT NULL,
  	FOREIGN KEY (matr_funcionario) REFERENCES FUNCIONARIOS (matricula),
	num_telefone BIGINT NOT NULL,
	PRIMARY KEY (matr_funcionario, num_telefone)
);

CREATE TABLE POSSUI (
	id_construtora INTEGER NOT NULL,
  	FOREIGN KEY (id_construtora) REFERENCES CONSTRUTORA (id),
	matr_fornecedor INTEGER NOT NULL,
  	FOREIGN KEY (matr_fornecedor) REFERENCES FORNECEDORES (matricula),
  	PRIMARY KEY(id_construtora, matr_fornecedor)
);

CREATE TABLE MATERIAIS_FORNECIDOS (
	id_construtora INTEGER NOT NULL,
    	matr_fornecedor INTEGER NOT NULL,
  	FOREIGN KEY (id_construtora, matr_fornecedor) REFERENCES POSSUI (id_construtora,matr_fornecedor),
	nome VARCHAR(30) NOT NULL,
	valor DECIMAL(10,2) NOT NULL,
	PRIMARY KEY(id_construtora, matr_fornecedor, nome)
);



-- Povoamento das Tabelas

-- CONSTRUTORA

INSERT INTO CONSTRUTORA VALUES
(1,11444777000161,'Ramos e Souza S.A.','Objetivo Construtora',1963,29906735,'Rua Alberto Farias',500,'Palmital','Linhares','ES'),
(4,24621401000127,'Nigro LTDA.','VX Buildings',2016,59122405,'Rua do Alvorecer',237,'Redinha','Natal','RN'),
(6,85133837000161,'Arcuri S.A.','Poupe Construções',2013,49043323,'Travessa Q2',5200,'São Conrado','Aracaju','SE'),
(8,02212482000179,'Kahneman Braga S.A.','KB Solutions',2000,57073593,'Avenida Francisco de Holanda',659,'Cidade Universitária','Maceió','AL'),
(9,80161366000181,'Paiva Beça S.A.','Paiva Beça',1996,70350717,'Quadra SHIGS 705 Bloco Q',23,'Asa Sul','Brasília','DF'),
(10,67181109000143,'Grupo TGM S.A.','TGM Buildings',1988,40713510,'Travessa Olímpia',84,'Itacaranha','Salvador','BA'),
(12,84485942000105,'Grupo Imperial LTDA.','Construtudo',2006,88040490,'Rua Rodolfo Manoel Bento',2202,'Trindade','Florianópolis','SC');

INSERT INTO CONSTRUTORA (id,cnpj,razao_social,nome_fantasia,ano_fundacao,cep,numero) VALUES
(2,08406249000103,'Bragança Lopes Edifícios S.A.','Bragança Lopes',1982,57062016,120),
(3,79031801000174,'James Hunter LTDA.','Hunter Construtora',2003,68506747,8729),
(5,28280576000179,'Construtec LTDA.','Construtec',2012,57071104,401),
(7,56691905000100,'Broken Faster S.A.','Buildility',1999,83055380,55),
(11,23051650000161,'Grupo Máxima S.A.','Skyline Contractors',1977,36033490,9);

-- CARGOS 

INSERT INTO CARGOS (cbo, nome, descricao) VALUES
(214205,'Engenheiro civil','Desenvolve projetos.'),
(710205,'Encarregado de Obras','Lê e executa projetos.' ),
(715210,'Pedreiro','Assenta tijolos e afins.'),
(951105,'Eletricista',null),
(142105,'Gerente Administrativo',null),
(724110,'Encanador','Monta sistemas de tubulações.'),
(716610,'Pintor',null),
(724440,'Serralheiro','Executar serviço serralheria'),
(782310,'Motorista',null),
(987654,'Estagiário',null);

-- FUNCIONÁRIOS

INSERT INTO FUNCIONARIOS (nome_completo,rg,cpf,salario,data_nascimento,sexo,matricula,qtd_filhos,id_construtora,cbo_cargos,matr_supervisiona) VALUES
('Marcelo Bezerra da Silva',8025305,35312564505,6358.17,'1981-07-20','M',68222,3,5,214205,null),
('Adriano Candal Matos',394664516,05361844101,5370.00,'2000-04-17','M',79046,0,5,710205,68222),
('Sávio Farias Rezende',348767407,46136784203,13102.85,'1968-05-29','M',88246,4,2,214205,null),
('Olga Castanho Pestana',210651416,37838835712,2546.37,'1987-12-08','F',76417,2,2,716610,88246),
('Adriele Pais Póvoas',331135036,01651314209,2479.25,'1994-05-18','F',76357,2,11,724110,null),
('Elielson Anjos Frossard',170646415,41135472203,8668.50,'1985-07-04','M',93480,3,7,214205,null),
('Lucas Felipe Consendey Falcão',398541930,65883037186,3324.68,'1998-05-05','M',51411,1,9,951105,null),
('Domingos Ascar Vasgestian',427791170,32217766830,2100.45,'1992-06-18','M',95837,4,1,715210,null),
('Severino Ervano Carmoriz',258247320,11286563291,3335.18,'1977-08-07','M',30498,5,2,715210,88246),
('Joemia Marins da Silva',223792767,20482242299,4588.96,'1996-09-11','F',37823,3,6,142105,null),
('Lucas Emanuel Reis Auzier',460875255,12721933302,2566.74,'1999-07-07','M',55557,2,12,951105,null),
('Emanuele Pereira da Silva',7076095,32565214535,5023.18,'1983-06-12','F',59632,4,8,142105,null),
('Bernardo Guedes Germano',231271165,76175438167,2200.58,'2002-10-30','M',48142,1,8,715210,59632),
('Flávio Cabral de Melo',2531861,23562114212,2507.09,'1986-11-25','M',78425,3,11,951105,null),
('Paulo Felipe Silva Bezerra',7075099,05466535212,2790.63,'1981-03-11','M',93244,2,2,715210,88246),
('Elisabeth França Lins',7536025,35415363515,1800.00,'2003-02-15','F',98236,0,6,987654,null),
('Juan Knupp Anastacio',225884549,73377450521,2188.74,'1993-01-08','M',67206,2,9,782310,51411),
('Geraldo Lourenço Rezende',25265528,13054913511,2566.19,'1990-11-26','M',75474,1,12,724440,55557),
('Caleb Vitorino Dores',461215317,55533923306,3321.41,'1977-10-16','M',66566,3,10,710205,null),
('Milena da Silva Medeiros',342184349,48984341185,1750.00,'1985-07-19','F',64583,2,10,987654,66566);

-- TELEFONES_FUNCIONARIOS

INSERT into TELEFONES_FUNCIONARIOS (matr_funcionario,num_telefone) VALUES
(79046,9234134112),(79046,46984091221),(79046,55993462479),(76417,38950352124),(76417,59988078828),(76357,85967842733),
(93480,89932711982),(93480,41955973592),(30498,89929673912),(37823,24905271826),(37823,36920696587),(66566,21932621806),
(64583,16983022351),(64583,53975107069),(64583,53974374902),(64583,30999986640),(75474,83913119690),(78425,57997926346),
(98236,27972444874),(67206,34924484798),(67206,34938128910),(95837,89933401058),(51411,87978995388),(93244,89984237470);

-- TELEFONES_CONSTRUTORA

INSERT INTO TELEFONES_CONSTRUTORA (id_construtora,num_telefone) VALUES
(1,2233491480),(1,6825674960),(2,8335075820),(3,3224182472),(3,7423327237),(3,6431382835),(5,6732172834),(5,3125375169),
(6,9321887814),(7,9525181423),(7,8427700060),(8,6926371174),(8,9836014368),(8,8923788620),(10,8233663633),(11,3427253871),
(11,8739341559),(12,9932545716),(12,9629044085);

-- FORNECEDORES

INSERT INTO FORNECEDORES (cnpj,razao_social,matricula,material_fornecido) VALUES
(76327991000183,'Lorenzetti S.A.',25252,'Luminárias'),
(02117255000164,'Connect Cimentos Ltda.',70198,'Cimento, argamassa e rejunte'),
(93353040000106,'Radial S.A.',94080,'Tilojos e blocos'),
(49259971000140,'Krona Tubos e Conexões S.A.',31780,'Tubulações Hidráulicas'),
(70823638000108,'Stam Ltda.',16021,'Areia, brita e concreto'),
(51906886000178,'Shirley Venoso Ltda.',47342,'Fechaduras'),
(80765170000104,'ConstruLar Brasil S.A.',29325,'Ferragens e Ferramentas'),
(47201534000140,'Signature Materiais S.A.',78956,null),
(93876400000146,'Genius S.A.',33158,'Tintas'),
(45726297000105,'Rede Construir Materiais S.A.',24857,null),
(96403265000100,'Copafer Comercial S.A.',45187,'Pisos e revestimentos'),
(37875731000190,'HN Construções Ltda.',34162,null),
(92037790000106,'Mega Engenharia Ltda.',96321,'Fios elétricos'),
(48540429000106,'CasaBella Acabamentos S.A.',33230,'Louças Sanitárias');
  
-- POSSUI

INSERT INTO POSSUI (id_construtora,matr_fornecedor) VALUES
(1,25252),(1,96321),(2,70198),(3,47342),(5,31780),(6,45187),(6,96321),(7,33158),(9,33158),
(9,16021),(10,33230),(11,25252),(12,94080),(12,70198),(12,45187);

-- MATERIAIS_FORNECIDOS
  
INSERT INTO MATERIAIS_FORNECIDOS (id_construtora,matr_fornecedor,nome,valor) VALUES
(1,25252,'Luminárias',10500.00),(1,96321,'Fio elétrico',20000.00),(2,70198,'Cimento',200000.00),
(2,70198,'Argamassa',100000.00),(2,70198,'Rejunte',70000.00),(3,47342,'Fechaduras',4500.00),
(5,31780,'Tubos de PVC',22354.12),(5,31780,'Tubos de aço',36541.95),(6,45187,'Pisos',12478.33),
(6,96321,'Fio elétrico',10000.00),(7,33158,'Tinta',9548.15),(9,33158,'15000 litros de tinta',15784.19),
(9,16021,'Areia',26115.96),(10,33230,'Louças Sanitárias',59971.00),(11,25252,'Luminárias',15000.00),
(12,94080,'Tijolos',30785.37),(12,70198,'Cimento',21669.84),(12,45187,'Revestimento',29108.79),
(12,94080,'Blocos de concreto',1308.62);



-- VIEWS

-- 1 - Criar uma view que liste a quantidade de funcionários por cargo. Ordene alfabeticamente pelo nome do cargo.

Create or REPLACE view VW_QTD_FUNC_CARGO AS
SELECT c.nome as Cargo, COUNT(f.cpf) as Qtd_funcionarios
FROM funcionarios f, cargos c
WHERE f.cbo_cargos = c.cbo
GROUP by c.nome
ORDER by c.nome;

-- 2 - Liste as Construtoras (CNPJ e nome fantasia) que são do Nordeste, ordenadas alfabeticamente pelo nome.

CREATE or REPLACE VIEW VW_CONSTRU_NE AS
SELECT nome_fantasia, cnpj from construtora
WHERE estado in ('PE','PB','SE','RN','PI','BA','CE','MA','AL')
ORDER by nome_fantasia;

/* 3 - Gere uma visão com os nomes dos funcionários, de suas respectivas construtoras e as cidades delas, ordenados alfabeticamente pelo nome fantasia da construtora e depois pelo nome do funcionário. */

CREATE or REPLACE VIEW VW_FUNC_CONSTRU AS
SELECT f.nome_completo as nome_funcionario, c.nome_fantasia as construtora, c.cidade as cidade_construtora
from funcionarios f RIGHT JOIN construtora c
ON f.id_construtora = c.id
ORDER by c.nome_fantasia, f.nome_completo;

/* 4 - Gerar uma visão com valor total da folha de pagamento de funcionários por construtora e
a média salarial de cada uma delas, com duas casas decimais. Ordene pelo nome fantasia da construtora.*/

CREATE or REPLACE VIEW VW_FOLHA_MEDIA AS
SELECT c.nome_fantasia as nome_construtora, sum(salario) as Folha_Pagamento, 
round(AVG(salario),2) as média_Salarial
from construtora c LEFT join funcionarios f
on c.id = f.id_construtora
GROUP by nome_fantasia
ORDER by nome_fantasia;

/* 5 - Gere uma visão que apresente:
 - o nome do funcionário, o seu cargo, sua idade e seu número de telefone
 - ordene pela idade decrescentemente e depois pelo cargo. */

CREATE or REPLACE VIEW VW_FUNC_CARGO_IDA_FONE AS
SELECT f.nome_completo as nome_funcionario, c.nome as cargo, extract(year from age(f.data_nascimento)) as idade, tf.num_telefone 
from funcionarios f LEFT JOIN cargos c ON f.cbo_cargos = c.cbo 
LEFT JOIN telefones_funcionarios tf on f.matricula = tf.matr_funcionario
ORDER by idade DESC, cargo;

SELECT * from VW_FUNC_CARGO_IDA_FONE;


-- PROCEDURES E FUNCTIONS

-- 1 - Criar um subprograma que retorne a diferença de idade do funcionário mais velho para o mais novo.

CREATE or replace FUNCTION diff_idade()
RETURNS INTEGER
LANGUAGE PLPGSQL AS $$
DECLARE
	diferenca_idade INTEGER;
BEGIN
	SELECT max(idade) - MIN(idade) FROM VW_FUNC_CARGO_IDA_FONE into diferenca_idade;
    RETURN diferenca_idade;
END; $$;

-- CHAMADA

SELECT diff_idade();


/* 2 - Criar um subprograma que atualiza a quantidade de filhos dos funcionários, recebendo a matrícula do funcionário e a quantidade de filhos atual. */

CREATE or replace PROCEDURE atualizar_filhos(matr_func INTEGER, qtde_filhos INTEGER)
LANGUAGE PLPGSQL AS $$
DECLARE
	matricula_func INTEGER;
BEGIN
	SELECT matricula FROM funcionarios f WHERE f.matricula = matr_func into matricula_func;
if (matricula_func is NULL) THEN
	RAISE EXCEPTION 'Matrícula não existe';
ELSEIF (qtde_filhos < 0) THEN
	RAISE EXCEPTION 'Valor inválido';
ELSE
	UPDATE funcionarios f set qtd_filhos = qtde_filhos WHERE f.matricula = matricula_func;
end if;
END; $$;

-- CHAMADA

call atualizar_filhos(76417,5);
SELECT * from funcionarios;


/* 3 - Criar um estrutura que retorne os nomes dos funcionários e seu cargo a partir do nome da construtora (nome fantasia), ordenados pelo nome dos funcionários. */

CREATE OR REPLACE FUNCTION funcionario_cargo(nome_construtora TEXT)
RETURNS TABLE (n_func VARCHAR(50), n_cargo VARCHAR(30))
LANGUAGE PLPGSQL AS $$
DECLARE
	existe_constru BOOLEAN;
bEGIN
	SELECT TRUE from construtora WHERE nome_construtora = nome_fantasia into existe_constru;
    if (existe_constru is NULL) THEN
    	raise EXCEPTION 'Construtora não cadastrada';
    ELSE
        return query SELECT f.nome_completo, c.nome
        from funcionarios f, cargos c, construtora co
        WHERE f.cbo_cargos = c.cbo and f.id_construtora = co.id and co.nome_fantasia = nome_construtora
        ORDER by f.nome_completo;
    end IF;
END;$$;

-- CHAMADA

SELECT * from funcionario_cargo('Bragança Lopes');

/* 4 - Crie um subprograma que cadastra um fornecedor recebendo o seu CNPJ e sua razão social como argumento e defina o número de matrícula que deve ser utilizado, inicializando com null os demais atributos. */

CREATE OR REPLACE PROCEDURE cadastra_fornecedor(add_cnpj bigint, add_razao_social varchar(30))
LANGUAGE PLPGSQL AS $$
DECLARE
	existe_cnpj BOOLEAN;
	existe_razao BOOLEAN;
    valor_novoMATR INTEGER;
BEGIN
        SELECT TRUE from fornecedores WHERE add_cnpj = cnpj into existe_cnpj;
        SELECT TRUE from fornecedores WHERE add_razao_social = razao_social into existe_razao;
    if (existe_cnpj is not null) or (existe_razao is not null) THEN  
		raise EXCEPTION 'Fornecedor já cadastrado';
    ELSE
    	SELECT max(matricula)+1 from fornecedores INTO valor_novoMATR;
        INSERT into fornecedores(cnpj, razao_social, matricula, material_fornecido) 
        VALUES (add_cnpj,add_razao_social,valor_novoMATR,NULL);
    	
    end if;
END; $$;

-- CHAMADA

call cadastra_fornecedor(15445415415616,'IFPE Ltda.');
SELECT * from fornecedores;

-- 5 - Crie um subprograma que liste os fornecedores (cnpj, nome, matricula) após o cadastro de um novo fornecedor.

CREATE TYPE type_lista_fornecedores as (
    cnpj_forn BIGINT,
    nome_forn TEXT,
    matricula_forn INTEGER
);

create or replace FUNCTION lista_fornecedores(cnpj_forn BIGINT, nome_forn TEXT)
returns SETOF type_lista_fornecedores as $$
DECLARE
	dados_fornecedores type_lista_fornecedores;
BEGIN
	call cadastra_fornecedor(cnpj_forn, nome_forn);
    
   	for dados_fornecedores in
       SELECT cnpj, razao_social, matricula
       from fornecedores
       LOOP RETURN NEXT dados_fornecedores;
       end LOOP;
   	RETURN;
END;$$ language plpgsql;

-- CHAMADA

SELECT * from lista_fornecedores(12345678910293,'Teste S.A.');


/* 6 - Criar um subprograma de preparação para demissão de um funcionário, que retorna sua matrícula e verifica se ele é supervisor ou não, através de seu CPF. Caso ele seja supervisor, atribuir null no cadastro dos funcionários que ele supervisiona. */

CREATE OR REPLACE FUNCTION verifica_funcionario_supervisor(cpf_func BIGINT)
RETURNS INTEGER
LANGUAGE PLPGSQL AS $$
DECLARE
	existe_func BOOLEAN;
    matr_func BIGINT;
    EhSupervisor BOOLEAN;
bEGIN
	SELECT TRUE from funcionarios f WHERE f.cpf = cpf_func into existe_func;
    SELECT f.matricula from funcionarios f WHERE f.cpf = cpf_func into matr_func;
    SELECT TRUE from funcionarios f WHERE f.matr_supervisiona = matr_func into EhSupervisor;
    if (existe_func is NULL) THEN
    	raise EXCEPTION 'Funcionário não cadastrado';
    ELSE 
    	if (EhSupervisor is not NULL) THEN
			UPDATE funcionarios set matr_supervisiona = NULL WHERE matr_supervisiona = matr_func;
       	end IF;
    return matr_func;
	end IF;
END;$$;

-- CHAMADA

SELECT verifica_funcionario_supervisor(41135472203);

-- 7 - Criar um subprograma que exclua os dados do funcionário demitido no banco de dados, a partir do seu CPF.

CREATE OR REPLACE PROCEDURE excluir_funcionario(cpf_funcionario BIGINT)
LANGUAGE PLPGSQL AS $$
DECLARE
    matr_func INTEGER;
    temTelefone BOOLEAN;
BEGIN
	SELECT verifica_funcionario_supervisor(cpf_funcionario) INTO matr_func;
    SELECT TRUE from telefones_funcionarios tf WHERE tf.matr_funcionario = matr_func INTO temTelefone;
    if (temTelefone is not NULL) THEN
    	DELETE from telefones_funcionarios tf WHERE tf.matr_funcionario = matr_func;
   	end if;
    DELETE FROM funcionarios f WHERE f.matricula = matr_func;
END; $$;

-- CHAMADA

call excluir_funcionario(35312564505);
SELECT * from funcionarios;

/* 8 - Para facilitar o entendimento da distribuição de idade nas construtoras, o sistema precisa ter a idade dos funcionários registrada. Desta forma, crie um subprograma que adiciona a coluna idade do tipo inteiro na tabela funcionarios e atualize o valor dessa coluna calculando a idade, a partir da data de nascimento dos funcionários desta mesma tabela. */

CREATE OR REPLACE PROCEDURE inserir_idade()
LANGUAGE PLPGSQL AS $$
BEGIN
	ALTER TABLE funcionarios ADD idade INTEGER;
	UPDATE funcionarios set idade = extract(year from age(data_nascimento));
END; $$;

-- CHAMADA

call inserir_idade();
SELECT *  from funcionarios;

/* 9 - Crie uma estrutura que, a partir da matrícula do fornecedor, retorne o telefone e o nome fantasia das construtoras com as quais ele tem relacionamento. */

CREATE TYPE type_info_constru as (
	constr_nome TEXT,
  	fone_const BIGINT
);

CREATE OR REPLACE FUNCTION fornecedor_construtora(fornecedor_matricula INTEGER)
RETURNS SETOF type_info_constru 
LANGUAGE PLPGSQL AS $$
DECLARE
	dados_constru type_info_constru;
	existe_forn BOOLEAN;
BEGIN
	SELECT TRUE from fornecedores WHERE matricula = fornecedor_matricula into existe_forn;
    if (existe_forn is NULL) THEN
    	raise EXCEPTION 'Fornecedor não cadastrado';
    end IF;
		for dados_constru in
    	SELECT co.nome_fantasia, tc.num_telefone 
        FROM construtora co, telefones_construtora tc 
        WHERE (tc.id_construtora in (SELECT DISTINCT id_construtora FROM possui 
               WHERE matr_fornecedor = fornecedor_matricula) AND
               co.id in (SELECT DISTINCT id_construtora FROM possui 
               WHERE matr_fornecedor = fornecedor_matricula))
        	   GROUP by co.nome_fantasia, tc.num_telefone
        loop RETURN NEXT dados_constru;
        end loop;
   	RETURN;
END; $$;

-- CHAMADA

SELECT * FROM fornecedor_construtora(47342);


-- TRIGGERS

/* 1 - Criar uma trigger que, não aceita o cadastro de novo funcionário caso ele tenha menos de 18 anos, a não ser para o cargo de estagiário, em que ele deve ter, no mínimo, 14 anos completos. */

create or REPLACE FUNCTION verificar_maior_idade ()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN
	if (EXTRACT(year from age(CURRENT_DATE,new.data_nascimento)) < 14) THEN
    	RAISE EXCEPTION 'Idade inválida para novo funcionário!';
    ELSEIF (EXTRACT(year from age(CURRENT_DATE,new.data_nascimento)) >= 14 and 
            EXTRACT(year from age(CURRENT_DATE,new.data_nascimento)) < 18) and 
    	   (new.cbo_cargos != 987654) THEN
		RAISE EXCEPTION 'Cargo ou idade inválido para novo funcionário!';
   end if;
return NEW;
END; $$;

create or REPLACE TRIGGER verificar_idade
BEFORE insert or update ON funcionarios
FOR EACH ROW
EXECUTE PROCEDURE verificar_maior_idade ();

-- CHAMADA

INSERT INTO funcionarios(nome_completo, rg, cpf, salario, data_nascimento, sexo, matricula, qtd_filhos, id_construtora, cbo_cargos, matr_supervisiona) 
VALUES ('Aldenis da Silva Sauro', 8522381, 25964431231, 1200.00, '2006-05-15', 'M', 96574, 0, 5, 987654, null);

SELECT * from funcionarios;
DELETE FROM funcionarios WHERE rg = 8522381;

/* 2 - Cada funcionário recebe um auxílio creche de 100 reais por filho. Logo, crie uma trigger para, caso haja atualização na quantidade de filhos de um funcionário, o valor de 100 reais deve ser incrementado (filhos nasceram) ou decrementado (filhos morreram) no valor do salário. */

create or REPLACE FUNCTION atualizar_aux_creche()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN
	if old.qtd_filhos < new.qtd_filhos THEN
    	UPDATE funcionarios set salario = salario + ((new.qtd_filhos - old.qtd_filhos)*100) WHERE matricula = new.matricula;
	ELSEIF old.qtd_filhos > new.qtd_filhos THEN
    	UPDATE funcionarios set salario = salario - ((old.qtd_filhos - new.qtd_filhos)*100) WHERE matricula = new.matricula;
   end if;
return NEW;
END; $$;

create or REPLACE TRIGGER atualizar_beneficio_creche
AFTER update ON funcionarios
FOR EACH ROW
EXECUTE PROCEDURE atualizar_aux_creche();

UPDATE funcionarios set qtd_filhos = 2 where matricula = 79046;
SELECT * from funcionarios;

/* 3 - Crie uma view que contenha os fornecedores que não têm materiais cadastrados. Ainda, crie uma trigger que, quando o usuário tentar inserir ou excluir um dado dessa view, ao invés disso, esse dado seja inserido ou deletado na tabela fornecedores. */

CREATE or REPLACE view forn_sem_material as 
SELECT * from fornecedores WHERE material_fornecido is NULL;

CREATE or REPLACE FUNCTION atualiza_fornecedor()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		INSERT INTO fornecedores VALUES (NEW.cnpj, NEW.razao_social, NEW.matricula);
    elseif (TG_OP = 'DELETE') THEN
    	DELETE FROM fornecedores WHERE matricula = OLD.matricula;
	END IF;
RETURN NULL;
END; $$;

CREATE or REPLACE TRIGGER dispara_fornecedor
INSTEAD OF INSERT or DELETE ON forn_sem_material
FOR EACH ROW
EXECUTE PROCEDURE atualiza_fornecedor();

-- CHAMADA

INSERT INTO forn_sem_material VALUES (64587566, 'Marcos da View', 258);
DELETE from forn_sem_material WHERE matricula = 258;

SELECT * FROM forn_sem_material;
SELECT * FROM fornecedores;
