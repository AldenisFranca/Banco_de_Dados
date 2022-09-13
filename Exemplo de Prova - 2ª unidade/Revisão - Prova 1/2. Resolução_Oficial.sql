#Questão 1
create table tipo(
  id integer primary key,
  nome varchar(30) not null UNIQuE,
  prateleira integer
);

create table brinquedo(
  ID integer PRIMARY key,
  nome varchar(30) not null,
  id_tipo integer,
  foreign key (id_tipo) REFERENCES tipo (id),
  preco decimal (5,2) NOT NULL,
  idade_indicativa integer
);

create table crianca(
  data_nasc DATE,
  id integer,
  nome varchar(30) not null unique,
  mae varchar(30) not null,
  primary key(id)
);

create table pertence (
  id_brinquedo INTEGER ,
  id_crianca INTEGER ,
  FOREIGN key (id_brinquedo) REFERENCES brinquedo(id),
  FOREIGN key (id_crianca) REFERENCES crianca(id),
  primary key (id_brinquedo, id_crianca)
);

#Questão 2
alter table produto add FOREIGN key (COD_FARMACIA) 
REFERENCES farmacia (codigo);

#Questão 3
alter table farmacia drop column endereco;

#Questão 4
INSERT INTO FARMACEUTICO VALUES (7322879,'Carolina Torres', 2);

#Questão 05
select nome AS 'PACIENTE', dependentes AS 'Qtde. de Dependentes' from paciente
where endereco IS NOT NULL;

#Questão 06
select DISTINCT especialidade from medico
where nome not like '% F%' and nome not like '% S%'

#Questão 07
select numero, andar from quarto
where cod_paciente IN(
  select codigo from paciente where data_nascimento BETWEEN '2000-01-01' and '2005-12-31')

#Questão 08
select nome from paciente
where codigo in (select cod_paciente from quarto)

#Questão 09
select nome from paciente
where codigo in (select cod_paciente from quarto q where q.andar =3 or andar =4 or andar=5) 
and data_nascimento >= '2000-01-01'

#questão 10
select nome, especialidade, salario from medico
where crm NOT IN (select crm_responsavel from paciente)

