-- Questão 1

CREATE TABLE TB_SETOR (
  codigo INTEGER PRIMARY KEY,
  descricao VARCHAR(40) UNIQUE NOT NULL,
  num_corredor INTEGER,
  responsavel VARCHAR(40)
);

CREATE TABLE TB_FORNECEDOR (
  codigo INTEGER PRIMARY KEY,
  nome VARCHAR(40) NOT NULL,
  nome_contato VARCHAR(40),
  num_contato INTEGER NOT NULL
);

CREATE TABLE TB_PRODUTO (
  id INTEGER PRIMARY KEY,
  nome VARCHAR(40) UNIQUE NOT NULL,
  un_medida VARCHAR(20) NOT NULL,
  tipo VARCHAR(40),
  cod_setor INTEGER NOT NULL,
  FOREIGN KEY(cod_setor) REFERENCES TB_SETOR(codigo),
  ativo BOOLEAN NOT NULL 
);

CREATE TABLE TB_COMPRAS (
  id_produto INTEGER,
  FOREIGN KEY(id_produto) REFERENCES TB_PRODUTO(id),
  quantidade INTEGER NOT NULL,
  preco DECIMAL(6,2) NOT NULL,
  data_compra date,
  cod_fornecedor INTEGER,
  FOREIGN KEY(cod_fornecedor) REFERENCES TB_FORNECEDOR(codigo),
  PRIMARY key (data_compra,id_produto,cod_fornecedor)
);

-- Questão 2

CREATE TABLE TB_TIPO (
  codigo INTEGER PRIMARY KEY,
  descricao VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE TB_PEÇA (
  id INTEGER PRIMARY KEY,
  descricao VARCHAR(40) NOT NULL,
  caracteristicas VARCHAR(20),
  cor VARCHAR(20),
  tamanho INTEGER NOT NULL,
  quantidade INTEGER NOT NULL,
  cd_tipo INTEGER,
  FOREIGN KEY(cd_tipo) REFERENCES TB_TIPO(codigo)
);

CREATE TABLE TB_COMBINA (
  id_peca1 integer not NULL,
  id_peca2 integer not NULL,
  estilo VARCHAR(30) NOT NULL
);

ALTER TABLE TB_COMBINA ADD PRIMARY key (id_peca1,id_peca2), 
ADD FOREIGN KEY (id_peca1) REFERENCES TB_PEÇA(id),
ADD FOREIGN KEY (id_peca2) REFERENCES TB_PEÇA(id);

INSERT into TB_PEÇA VALUES
(1,'calça jeans',null,'azul',44,10,null),
(2,'bermuda lycra',null,'preto',48,15,null),
(3,'camisa social',null,'rosa',40,12,null);

-- Letra A

-- Versão 1:
ALTER TABLE TB_COMBINA ADD PRIMARY key (id_peca1,id_peca2) AND
ALTER TABLE TB_COMBINA ADD FOREIGN KEY(id_peca1,id_peca2) REFERENCES TB_PEÇA(id);

-- Versão 2:
ALTER TABLE TB_COMBINA
ADD PRIMARY key (id_peca1,id_peca2),
ADD FOREIGN KEY(id_peca1,id_peca2) REFERENCES TB_PEÇA(id);

-- Versçao 3 (a que deu certo, mas só ADD 1 chave estrangeira):
ALTER TABLE TB_COMBINA ADD PRIMARY key (id_peca1,id_peca2), 
ADD FOREIGN KEY (id_peca1) REFERENCES TB_PEÇA(id),
ADD FOREIGN KEY (id_peca2) REFERENCES TB_PEÇA(id);


-- Letra B
SELECT id, descricao, quantidade - 3,tamanho,cor FROM TB_PEÇA
WHERE descricao = 'calça jeans' AND tamanho = 44 and cor = 'azul'

-- Letra C
INSERT into TB_PEÇA (id,descricao,cor,tamanho,quantidade) VALUES
(23,'Short','Branco',38,10);