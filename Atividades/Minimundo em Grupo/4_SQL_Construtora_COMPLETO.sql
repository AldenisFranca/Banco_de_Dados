CREATE TABLE CONSTRUTORA (
	id INTEGER PRIMARY KEY NOT NULL,
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
	cbo INTEGER PRIMARY KEY NOT NULL,
    	nome VARCHAR(30) NOT NULL,
    	descricao VARCHAR(30)
);

CREATE TABLE FORNECEDORES (
	cnpj BIGINT UNIQUE NOT NULL,
  	razao_social VARCHAR(30) NOT NULL,
  	matricula INTEGER PRIMARY KEY NOT NULL,
  	material_fornecido VARCHAR(30)
);

CREATE TABLE FUNCIONARIOS (
	nome_completo VARCHAR(50) NOT NULL,	
    	rg INTEGER UNIQUE NOT NULL,
	cpf BIGINT UNIQUE NOT NULL,
    	salario DECIMAL(7,2) NOT NULL,
    	data_nascimento	DATE NOT NULL,
    	sexo VARCHAR(1)	NOT NULL,
	matricula INTEGER PRIMARY KEY NOT NULL,
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

DROP TABLE TELEFONES_CONSTRUTORA;
DROP TABLE FUNCIONARIOS;

CREATE TABLE POSSUI (
	id_construtora INTEGER NOT NULL,
  	FOREIGN KEY (id_construtora) REFERENCES CONSTRUTORA (id),
	matr_fornecedor INTEGER NOT NULL,
  	FOREIGN KEY (matr_fornecedor) REFERENCES FORNECEDORES (matricula),
  	PRIMARY KEY(id_construtora, matr_fornecedor)
);

CREATE TABLE MATERIAIS_FORNECIDOS (
	id_construtora INTEGER NOT NULL, 
  	FOREIGN KEY (id_construtora) REFERENCES POSSUI (id_construtora),
    	matr_fornecedor INTEGER NOT NULL, 
  	FOREIGN KEY (matr_fornecedor) REFERENCES POSSUI (matr_fornecedor),
    	nome VARCHAR(30) NOT NULL,
    	valor DECIMAL(10,2) NOT NULL,
    	PRIMARY KEY(id_construtora, matr_fornecedor, nome)
);

-- --------------------------------------------------------------------------------------------------------------------------
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

SELECT COUNT(*) from CONSTRUTORA WHERE razao_social LIKE '% ltda.';
SELECT * from CONSTRUTORA;
SELECT * FROM CARGOS;
SELECT * from FUNCIONARIOS;
SELECT * from TELEFONES_FUNCIONARIOS;
SELECT * from TELEFONES_CONSTRUTORA;
SELECT * FROM FORNECEDORES;
SELECT * FROM MATERIAIS_FORNECIDOS;
SELECT * FROM POSSUI;

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
DELETE FROM FUNCIONARIOS;
DELETE FROM TELEFONES_CONSTRUTORA;

INSERT INTO FUNCIONARIOS (nome_completo,rg,cpf,salario,data_nascimento,sexo,matricula,qtd_filhos,id_construtora,cbo_cargos,matr_supervisiona) VALUES
('Marcelo Bezerra da Silva',8025305,35312564505,6358.17,'1981-07-20','M',68222,3,5,214205,null), -- eng
('Adriano Candal Matos',394664516,05361844101,5370.00,'2000-04-17','M',79046,0,5,710205,68222), -- ENCARREGADO
('Sávio Farias Rezende',348767407,46136784203,13102.85,'1968-05-29','M',88246,4,2,214205,null), -- eng
('Olga Castanho Pestana',210651416,37838835712,2546.37,'1987-12-08','F',76417,2,2,716610,88246), -- PINTOR
('Adriele Pais Póvoas',331135036,01651314209,2479.25,'1994-05-18','F',76357,2,11,724110,null), -- encanador
('Elielson Anjos Frossard',170646415,41135472203,8668.50,'1985-07-04','M',93480,3,7,214205,null), -- engenheiro
('Lucas Felipe Consendey Falcão',398541930,65883037186,3324.68,'1998-05-05','M',51411,1,9,951105,null), -- eletricista
('Domingos Ascar Vasgestian',427791170,32217766830,2100.45,'1992-06-18','M',95837,4,1,715210,null), -- pedreiro
('Severino Ervano Carmoriz',258247320,11286563291,3335.18,'1977-08-07','M',30498,5,2,715210,88246), -- PEDREIRO
('Joemia Marins da Silva',223792767,20482242299,4588.96,'1996-09-11','F',37823,3,6,142105,null), -- GERENTE
('Lucas Emanuel Reis Auzier',460875255,12721933302,2566.74,'1999-07-07','M',55557,2,12,951105,null), -- eletricista
('Emanuele Pereira da Silva',7076095,32565214535,5023.18,'1983-06-12','F',59632,4,8,142105,null), -- gere
('Bernardo Guedes Germano',231271165,76175438167,2200.58,'2002-10-30','M',48142,1,8,715210,59632), -- pedreiro
('Flávio Cabral de Melo',2531861,23562114212,2507.09,'1986-11-25','M',78425,3,11,951105,null), -- eletr
('Paulo Felipe Silva Bezerra',7075099,05466535212,2790.63,'1981-03-11','M',93244,2,2,715210,88246), -- pedr
('Elisabeth França Lins',7536025,35415363515,1800.00,'2003-02-15','F',98236,0,6,987654,null), -- estag
('Juan Knupp Anastacio',225884549,73377450521,2188.74,'1993-01-08','M',67206,2,9,782310,51411), -- moto
('Geraldo Lourenço Rezende',25265528,13054913511,2566.19,'1990-11-26','M',75474,1,12,724440,55557), -- serra
('Caleb Vitorino Dores',461215317,55533923306,3321.41,'1977-10-16','M',66566,3,10,710205,null), -- encarr
('Milena da Silva Medeiros',342184349,48984341185,1750.00,'1985-07-19','F',64583,2,10,987654, ); -- estag

INSERT into TELEFONES_FUNCIONARIOS (matr_funcionario,num_telefone) VALUES
(79046,9234134112),(79046,46984091221),(79046,55993462479),(76417,38950352124),(76417,59988078828),(76357,85967842733),
(93480,89932711982),(93480,41955973592),(30498,89929673912),(37823,24905271826),(37823,36920696587),(66566,21932621806),
(64583,16983022351),(64583,53975107069),(64583,53974374902),(64583,30999986640),(75474,83913119690),(78425,57997926346),
(98236,27972444874),(67206,34924484798),(67206,34938128910),(95837,89933401058),(51411,87978995388),(93244,89984237470);

INSERT INTO TELEFONES_CONSTRUTORA (id_construtora,num_telefone) VALUES
(1,2233491480),(1,6825674960),(2,8335075820),(3,3224182472),(3,7423327237),(3,6431382835),(5,6732172834),(5,3125375169),
(6,9321887814),(7,9525181423),(7,8427700060),(8,6926371174),(8,9836014368),(8,8923788620),(10,8233663633),(11,3427253871),
(11,8739341559),(12,9932545716),(12,9629044085);

INSERT INTO FORNECEDORES (cnpj,razao_social,matricula,material_fornecido) VALUES
(76327991000183,'Lorenzetti S.A.',25252,'Luminárias'),(02117255000164,'Connect Cimentos Ltda.',70198,'Cimento, argamassa e rejunte'),
(93353040000106,'Radial S.A.',94080,'Tilojos e blocos'),(49259971000140,'Krona Tubos e Conexões S.A.',31780,'Tubulações Hidráulicas'),
(70823638000108,'Stam Ltda.',16021,'Areia, brita e concreto'),(51906886000178,'Shirley Venoso Ltda.',47342,'Fechaduras'),
(80765170000104,'ConstruLar Brasil S.A.',29325,'Ferragens e Ferramentas'),(47201534000140,'Signature Materiais S.A.',78956,null),
(93876400000146,'Genius S.A.',33158,'Tintas'),(45726297000105,'Rede Construir Materiais S.A.',24857,null),
(96403265000100,'Copafer Comercial S.A.',45187,'Pisos e revestimentos'),(37875731000190,'HN Construções	Ltda.',34162,null),
(92037790000106,'Mega Engenharia Ltda.',96321,'Fios elétricos'),(48540429000106,'CasaBella Acabamentos S.A.',33230,'Louças Sanitárias');
  
-- (51906886000178,'Shirley Venoso Ltda.',47342,'Fechaduras'), (80765170000104,'ConstruLar Brasil S.A.',29325,'Ferramentas para trabalho'),
-- (93876400000146,'Genius S.A.',33158,'200 pincéis'),

INSERT INTO POSSUI (id_construtora,matr_fornecedor) VALUES
(1,25252),(1,96321),(2,70198),(3,47342),(5,31780),(6,45187),(6,96321),(7,33158),(9,33158),
(9,16021),(10,33230),(11,25252),(12,94080),(12,70198),(12,45187);
  
INSERT INTO MATERIAIS_FORNECIDOS (id_construtora,matr_fornecedor,nome,valor) VALUES
(1,25252,'350 Luminárias',10500.00),(1,96321,'2000 m de fio elétrico',20000.00),(2,70198,'10 t de cimento',200000.00),
(2,70198,'3 t de argamassa',100000.00),(2,70198,'1 t de rejunte',70000.00),(3,47342,'300 Fechaduras',4500.00),
(5,31780,'200 m de tubos de PVC',22354.12),(5,31780,'100 m tubos de aço',36541.95),(6,45187,'500 m² de Pisos',12478.33),
(6,96321,'1000 m de fio elétrico',10000.00),(7,33158,'10000 litros de tinta',9548.15),(9,33158,'15000 litros de tinta',15784.19),
(9,16021,'20 t de areia',26115.96),(10,33230,'100 Louças Sanitárias',59971.00),(11,25252,'500 Luminárias',15000.00),
(12,94080,'2 milheiros de tijolos',30785.37),(12,70198,'1 t de cimento',21669.84),(12,45187,'600 m² de revestimento',29108.79),
(12,94080,'300 blocos de concreto',1308.62);
  
-- CONSULTAS

-- Qual(ou quais) o(s) id e nome(s) fantasia da(s) construtora(s) não têm funcionário e nem telefone cadastrado?

SELECT id, nome_fantasia as 'Nome Fantasia' FROM CONSTRUTORA WHERE id not in ( 
SELECT DISTINCT FUNCIONARIOS.id_construtora 
FROM FUNCIONARIOS left OUTER join TELEFONES_CONSTRUTORA on FUNCIONARIOS.id_construtora = TELEFONES_CONSTRUTORA.id_construtora
UNION
SELECT DISTINCT TELEFONES_CONSTRUTORA.id_construtora
FROM TELEFONES_CONSTRUTORA left OUTER join FUNCIONARIOS on FUNCIONARIOS.id_construtora = TELEFONES_CONSTRUTORA.id_construtora 
  RIGHT JOIN CONSTRUTORA ON (CONSTRUTORA.id != FUNCIONARIOS.id_construtora OR 
                             CONSTRUTORA.id != TELEFONES_CONSTRUTORA.id_construtora));



--SELECT id, nome_fantasia as 'Nome Fantasia' FROM CONSTRUTORA WHERE id not in 
--((SELECT id_construtora FROM FUNCIONARIOS WHERE id_construtora IS NOT NULL) and 
-- (SELECT id_construtora FROM TELEFONES_CONSTRUTORA WHERE num_telefone IS NOT NULL));


--SELECT DISTINCT CONSTRUTORA.id, CONSTRUTORA.nome_fantasia as 'Nome Fantasia' FROM CONSTRUTORA,FUNCIONARIOS,TELEFONES_CONSTRUTORA
-- WHERE CONSTRUTORA.id not in ((FUNCIONARIOS.id_construtora IS NOT NULL) and (TELEFONES_CONSTRUTORA.id_construtora IS NOT NULL));


-- Quais construtoras possuem pelo menos 2 funcionários cadastrados? Exiba as colunas como 'Construtora' e 'Qtde. Funcionários'.
SELECT CONSTRUTORA.nome_fantasia as 'Construtora', COUNT(FUNCIONARIOS.cpf) as 'Qtde. Funcionários' from FUNCIONARIOS, CONSTRUTORA
WHERE FUNCIONARIOS.id_construtora = CONSTRUTORA.id group by CONSTRUTORA.nome_fantasia HAVING COUNT(FUNCIONARIOS.cpf) >= 2;

-- Quais funcionários não são pais?
SELECT nome_completo FROM FUNCIONARIOS WHERE qtd_filhos = 0 and sexo = 'M';

-- Quais os nomes e matrículas dos funcionários que recebem mais de 4000 de salário e tem mais de 30 anos?
SELECT nome_completo, matricula FROM FUNCIONARIOS WHERE salario > 4000.00 and data_nascimento < '1992-01-25';

-- Quantos funcionários não tem telefone cadastrado?
SELECT COUNT(*) as 'Qtde. Funcionários' FROM FUNCIONARIOS WHERE matricula not in 
(SELECT DISTINCT matr_funcionario from TELEFONES_FUNCIONARIOS);

-- Qual o nome do funcionário mais novo e em qual construtora ele(a) trabalha?
SELECT FUNCIONARIOS.nome_completo, CONSTRUTORA.nome_fantasia FROM FUNCIONARIOS, CONSTRUTORA 
WHERE FUNCIONARIOS.data_nascimento = (SELECT max(data_nascimento) FROM FUNCIONARIOS) 
and CONSTRUTORA.id = FUNCIONARIOS.id_construtora;

-- Quantos cargos não possuem descrição?
SELECT COUNT(*) FROM CARGOS WHERE descricao is NULL;

-- Quais os nomes e CNPJ dos fornecedores que são Sociedade Limitada, ou seja, LTDA.? Ordene-os pela matrícula.
SELECT razao_social, cnpj FROM FORNECEDORES WHERE razao_social LIKE '%ltda.%' ORDER BY matricula;

-- Informe a razão social de 5 construtoras que não são Sociedade Limitada, ou seja, LTDA.
SELECT razao_social FROM CONSTRUTORA WHERE razao_social not LIKE '%ltda.%' LIMIT 5;

-- Qual a média salarial da construtora Bragança Lopes?
SELECT avg(salario) as 'Média Salarial' FROM FUNCIONARIOS WHERE id_construtora =
 (SELECT id FROM CONSTRUTORA WHERE nome_fantasia = 'Bragança Lopes')
															  
-- Quais cidades do Nordeste do país possuem construtoras? Agrupe-as por estado e exiba-os.
SELECT cidade, estado FROM CONSTRUTORA WHERE estado in ('AL','BA','PE','PB','PI','CE','MA','SE','RN') GROUP BY estado;

-- Qual o custo total que a construtora Construtudo tem na compra de materiais?
SELECT sum(valor) as 'Custo Total' FROM MATERIAIS_FORNECIDOS WHERE id_construtora = 
(SELECT id FROM CONSTRUTORA WHERE nome_fantasia = 'Construtudo');

-- Quantos funcionários trabalham em cada construtora citada?
SELECT CONSTRUTORA.nome_fantasia, COUNT(FUNCIONARIOS.matricula) as 'Qtde. Funcionários' FROM FUNCIONARIOS, CONSTRUTORA
WHERE CONSTRUTORA.id = FUNCIONARIOS.id_construtora GROUP BY CONSTRUTORA.nome_fantasia;

-- Qual o nome e a idade da construtora mais antiga? 
SELECT nome_fantasia, (2022-ano_fundacao) as 'idade' FROM CONSTRUTORA WHERE ano_fundacao = 
(SELECT MIN(ano_fundacao) FROM CONSTRUTORA);

-- Que funcionário supervisiona o(a) estagiário(a)?
SELECT nome_completo FROM FUNCIONARIOS WHERE matricula in (SELECT matr_supervisiona FROM FUNCIONARIOS WHERE
cbo_cargos in (SELECT cbo FROM CARGOS WHERE nome = 'Estagiário'));

-- Supervisor x supervisionados
-- Quais funcionários supervisionam outros?
SELECT nome_completo as 'Supervisor', nome_completo as 'Supervisionado' FROM FUNCIONARIOS
WHERE matricula = matr_supervisiona

FROM FUNCIONARIOS)
GROUP by matr_supervisiona;

-- http://www.gerarcnpjecpf.com.br/
-- https://www.geradordecep.com.br/