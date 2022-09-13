CREATE TABLE medico (
CRM integer PRIMARY key, nome varchar (30),
especialidade varchar(20), salario double (7,2)
);

CREATE TABLE paciente (
codigo integer PRIMARY key, nome varchar (30),
CPF Integer unique, dependentes integer,
endereco varchar (50), data_nascimento DATE,
crm_responsavel integer, FOREIGN key (crm_responsavel) REFERENCES medico (CRM)
);

CREATE TABLE quarto (
numero integer PRIMARY key, andar integer,
cod_paciente integer, FOREIGN key (cod_paciente) REFERENCES paciente (codigo)
);

INSERT INTO medico VALUES
(123,'Maria Fernandes','Endocrinologista',7625.98), (726,'Carolina Silva','Cardiologista',4151.98),
(918,'Carlos Bezerra Salgueiro','Cardiologista',8172.98), (162,'Adriana Santos','Pediatra',8273.12),
(362,'Jasmine Mendes','Cardiologista',3817.92), (638,'Helena Fagundes','Pediatra',11827.01);

INSERT INTO paciente VALUES
(1,'Vera Lucia',18291,3,'Rua Ali','1987-05-20',123), (2,'Simone Vasques',10212,6,'Rua Acolá','1965-11-08',726),
(3,'Pedro Rangel',18261,6,'Rua Lapidas','1981-12-06',123), (4,'Marília Mendonça',38471,2,'Rua Manepá','1998-09-13',362), 
(5,'Xico Xavier',93736,0,null,'2004-04-30',726), (6,'Valeska Cibele',52621,0,'Rua Neiva','2008-05-21',123), 
(7,'Carla Ribeiro',03982,0,'Rua Carvató','2016-03-16',162), (8,'Jaque Feitosa',91826,4,null,'1980-04-12',162), 
(9,'Lua Burgos',73612,8,'Rua Arlindo','1940-05-15',918), (10,'Jessica Andrade',82711,5,'Rua Mendes Sá','2000-07-04',918), 
(11,'Linda Torres',17261,0,'Rua Piancó','2014-10-10',638);

INSERT INTO quarto VALUES
(101,1,2),(102,1,null),(103,1,null),(104,1,3),(201,2,4),
(301,3,1),(401,4,5),(302,3,2),(403,4,10),(202,2,11),(404,4,10);

-- 05
SELECT nome AS 'Paciente', dependentes as 'Qtde. de Dependentes' FROM paciente
WHERE endereco is NOT null

-- 06
SELECT DISTINCT especialidade from medico
WHERE nome NOT LIKE '% F%' and nome NOT LIKE '% S%'
-- WHERE not(nome LIKE '% F%' or nome LIKE '% S%')

-- 07
SELECT numero, andar FROM quarto
WHERE cod_paciente in(
  SELECT codigo FROM paciente WHERE data_nascimento BETWEEN '2000-01-01' and '2005-12-31')

-- 08
SELECT nome FROM paciente
WHERE codigo IN(SELECT cod_paciente FROM quarto)

-- 09
SELECT nome FROM paciente
WHERE codigo IN(SELECT cod_paciente FROM quarto WHERE andar in(3,4,5))
and data_nascimento > '2000-01-01'

-- 10
SELECT nome, especialidade, salario FROM medico
WHERE crm not in(SELECT crm_responsavel FROM paciente)
ORDER by 3, 1
