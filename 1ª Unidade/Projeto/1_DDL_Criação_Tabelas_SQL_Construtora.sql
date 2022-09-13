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
