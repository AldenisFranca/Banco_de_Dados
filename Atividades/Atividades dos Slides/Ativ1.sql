/* CÓDIGOS ANTES DE RESPONDER A ATIVIDADE: */

/* Criação das Tabelas: */

CREATE TABLE artista (
     codigo INTEGER PRIMARY KEY,    
     nome_artista VARCHAR(30) NOT NULL,
     pais VARCHAR(20) not NuLl,    
     salario DECIMAL(8,2)
);

CREATE TABLE musica (
     codigo INTEGER PRIMARY KEY,    
     titulo VARCHAR(40),   
     ano_composicao INTEGER,   
     duracao integer,    
     cod_artista INTEGER,    
     FOREIGN KEY (cod_artista) REFERENCES artista (codigo)
);

/* Preenchendo as tabelas: */

INSERT INTO artista VALUES
(1, 'Djavan','Brasil',null);

INSERT INTO artista VALUES
(2, 'Dominguinhos','Brasil',0.0),
(3, 'Lulu Santos','Brasil',13982.87);

INSERT INTO artista (codigo,nome_artista, pais) VALUES
(4, 'Jack Johnson','EUA');

/* Atualizando o salário de Dominguinhos. */

UPDATE artista SET
pais = 'Brasil', salario = 10000.00
WHERE nome_artista= 'Dominguinhos'; 

/* Visualizando as tabelas: */

SELECT * FROM artista;
SELECT * FROM musica;

/* ATIVIDADE: */

/* 1. Inserir uma música: Título: ‘Meu Bem-querer’, Ano: 1979, Duração: 172, Autor: Djavan. */

INSERT INTO musica VALUES (1,'Meu Bem-querer',1979,172,1);

/* 2. Selecionar os nomes e os salários de todos os artistas. */

SELECT nome_artista,salario FROM artista;

/* 3. Selecionar os nomes e os salários dos artistas que são brasileiros. */

SELECT nome_artista,salario FROM artista WHERE pais='Brasil';

/* 4. Apagar os artistas que não são brasileiros. */

DELETE FROM artista WHERE pais != 'Brasil';

/* 5. Atualizar a duração da música ‘Meu Bem-querer’ para 189. */

UPDATE musica SET duracao=189 WHERE titulo='Meu Bem-querer';

/* 6. Inserir 3 músicas com os seguintes dados: */

INSERT INTO musica (codigo,titulo,ano_composicao,cod_artista) VALUES (2,'Um certo alguém',1982,3);
INSERT INTO musica (codigo,titulo,ano_composicao,duracao,cod_artista) VALUES (3,'Lilás',1984,167,1);
INSERT INTO musica (codigo,titulo,duracao,cod_artista) VALUES (4,'Tempos Modernos',180,3);

/* OU PODE FAZER ASSIM TAMBÉM: */

INSERT INTO MUSICA (CODIGO, TITULO, ANO, DURACAO, AUTOR) VALUES 
(2,'UM CERTO ALGUÉM', 1982, NULL, 'LULU_SANTOS'),
(3,'LILÁS', 1984, 167, 'DJAVAN'),
(4,'TEMPOS MODERNOS', NULL, 180, 'LULU_SANTOS')
