create table setor(
  cod_setor  serial PRIMARY key,
  nome_setor varchar (30)
);
create table produto(
  cod_produto  serial PRIMARY key, 
  nome_produto varchar(30), 
  preço decimal (8,2), 
  categoria varchar(30), 
  cd_setor integer,
  FOREIGN key (cd_setor) REFERENCES setor (cod_setor)
);
CREATE TABLE fornecedor (
  cod_fornecedor  serial PRIMARY key,
  nome_fornecedor varchar(30),  
  cidade varchar(30)
);
CREATe TABLE forn_Prod(
  cd_fornecedor integer, 
  cd_produto integer,
  PRIMARY key (cd_fornecedor,cd_produto),
  FOREIGN key (cd_fornecedor) REFERENCES fornecedor (cod_fornecedor),
  FOREIGN key (cd_produto) REFERENCES produto (cod_produto)  
);

--Inserts em setor
insert into setor values 
(1,'Higiene'), 
(2, 'Eletrônicos'), 
(3,'Alimentação'), 
(4, 'Vestuário');

--Inserts em Fornecedor
insert into fornecedor values
(1,'Unilever','São Paulo'),
(2,'Fiat','Goiana'),
(3,'Apple','Nova Iorque'),
(4,'Hyundai','Rio de Janeiro'),
(5,'São Braz','Recife'),
(6,'Sadia','Miranda');

--Inserts em produto
insert into produto values 
(1, 'escova de dente', 7.87,null, 1),
(2, 'Carro', 42162.98,'SUV', null),
(3, 'papel higiênico', 12.34, 'Higiente pessoal',1),
(4, 'iPad', 5182.42, 'Tablet',2),
(5, 'iPhone', 8182.42, 'Celular',2),
(6, 'Café', 6.98, null,3);

inSert into forn_prod VALUES (2,2),(4,2),(3,4),(3,5),(1,1),(1,3),(1,6),(5,6);