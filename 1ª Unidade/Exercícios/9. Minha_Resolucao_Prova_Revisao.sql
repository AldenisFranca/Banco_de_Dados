CREATE TABLE artista (
	codigo serial PRIMARY KEY, 
	nome_artista VARCHAR(30),
	país VARCHAR (20),
	SALARIO DECIMAL (8,2)
);
  
CREATE TABLE musica (
	codigo serial PRIMARY KEY, 
	título VARCHAR(40), 
	ano_composicao INTEGER,
	duracao INTEGER, 
	cod_artista INTEGER,
	FOREIGN KEY (cod_artista) REFERENCES artista (codigo)
);

CREATE TABLE album (
	CODIGO serial PRIMARY KEY, 
	NOME VARCHAR(40),
	pode_lancar boolean,
	dt_lancamento DATE
);

CREATE TABLE faz_parte (
	cod_musica INTEGER,
	cod_album INTEGER,
	PRIMARY KEY (cod_musica, cod_album),
	FOREIGN KEY (cod_musica) REFERENCES musica (codigo),
	FOREIGN KEY (cod_album) REFERENCES album (codigo)
);


Insert into Artista VALUES 
(1, 'Djavan','Brasil',null),
(2, 'Dominguinhos','Brasil',null),
(3, 'Lulu Santos','Brasil',null),
(4, 'Jack Johnson','EUA',null);

insert into musica VALUES 
(1,'Meu Bem Querer',1979,179,1),
(2,'Better Together',2005,250,4),
(3,'Lilás',1984,167,1),
(4,'Um certo alguém',1982,202,3),
(5,'Banana Pancakes',2005,316,4),
(6,'Tempos Modernos',1982,180,3),
(7,'A cura',1988,165,3),
(8,'Oceano',1989,192,1),
(9,'Se...',1992,131,1),
(10,'Pétala',1982,203,1);

INSERT INTO album VALUES 
(1, 'Romântico Brasileiro',false,null),
(2, 'Romântico Internacional',false,null),
(3, 'Romântico Misto',true,null);

INSERT INTO faz_parte values 
(1,1),(2,2),(5,2),(3,1),(3,3),(4,3),(2,3),(5,3),(10,3),(9,1);


-- 1
CREATE or REPLACE VIEW VW_MUSICAS_SEM_ALBUM AS
SELECT musica.título, artista.nome_artista from musica, artista
WHERE musica.cod_artista = artista.codigo AND musica.codigo not in
  (SELECT cod_musica FROM faz_parte WHERE cod_album is not NULL);

DROP VIEW VW_MUSICAS_SEM_ALBUM;

-- 2
CREATE VIEW Artista_qtdemusica AS
SELECT artista.nome_artista, COUNT(musica.codigo) as Qtd_Musicas FROM artista, musica
WHERE artista.codigo = musica.cod_artista
GROUP by artista.nome_artista;

-- SELECT * FROM Artista_qtdemusica;
-- DROP VIEW Artista_qtdemusica;

-- 3
SELECT nome_artista FROM Artista_qtdemusica
WHERE Qtd_Musicas >= 3 ORDER BY Qtd_Musicas DESC;


--- QUESTÃO 4
create view musicas_fora_album AS
select título, nome_artista 
from musica JOIN artista ON cod_artista=artista.codigo
where musica.codigo NOT IN (select cod_musica from faz_parte);

--- QUESTÃO 5
CREATE OR REPLACE VIEW ARTISTA_QTDEMUSICA AS
select nome_artista, COUNT(musica.título) AS QTDE_MUSICA
from musica RIGHT JOIN artista ON cod_artista=artista.codigo
GROUP BY nome_artista;

--- QUESTÃO 6
SELECT nome_artista FROM artista_qtdemusica
WHERE QTDE_MUSICA >=3 
ORDER BY QTDE_MUSICA DESC

--- QUESTÃO 7
CREATE OR REPLACE FUNCTION qtdeMusicas_album (n_album text)
returns INTEGER
LANGUAGE PLPGSQL AS $$
declare 
	qtde integer;
BEGIN
	select count(cod_musica)
      from faz_parte, album where faz_parte.cod_album=album.codigo
      AND album.nome = n_album INTO qtde;
    RETURN qtde;
END;$$;

--- QUESTÃO 8
CREATE or replace PROCEDURE inserir_album (nome_album text)
LANGUAGE PLPGSQL AS $$
DECLARE
var_novoID INTEGER;
begin
	select max(codigo)+1 from album INTO var_novoID;
    insert into album values (var_novoID,nome_album,false,null);
    --Caso o serial tenha sido usado corretamente, pode usar a solução abaixo:
    --insert into album(nome,pode_lancar,dt_lancamento) values (nome_album,false,null);    
end;$$;

--- QUESTÃO 9
CREATE or replace PROCEDURE inserir_musica (m_titulo text, m_duracao integer, a_nome text)
LANGUAGE PLPGSQL AS $$
DECLARE
   v_idArtista INTEGER;
   v_idMusica integer;
begin
   select codigo from artista where nome_artista=a_nome INTO v_idArtista;
   if v_idArtista is null THEN
   		select max(codigo) + 1 from artista into v_idArtista;
   		insert into artista values (v_idArtista, a_nome, null, null);
   end if;
   
   select max(codigo)+1 from musica into v_idMusica;
   insert into musica values (v_idMusica,m_titulo,2020,m_duracao,v_idArtista);   
end;$$;

call inserir_musica('Eita lala', 8961, 'Tia Carol');

--- QUESTÃO 10
CREATE OR REPLACE FUNCTION musicas_emalbum (n_album text)
returns table (n_artista varchar(30), qtde_musicas BIGINT)
LANGUAGE PLPGSQL AS $$
bEGIN
	return query select artista.nome_artista, count(musica.codigo)
      from faz_parte, album, musica, artista 
      where faz_parte.cod_album=album.codigo AND faz_parte.cod_musica=musica.codigo 
      		AND musica.cod_artista=artista.codigo
      AND album.nome = n_album
      group by artista.nome_artista;
END;$$;

--- QUESTÃO 11
CREATE OR REPLACE FUNCTION musicas_emalbum (n_album text)
returns table (n_artista varchar(30), qtde_musicas BIGINT)
LANGUAGE PLPGSQL AS $$
bEGIN
	return query select artista.nome_artista, count(musica.codigo)
      from faz_parte, album, musica, artista 
      where faz_parte.cod_album=album.codigo AND faz_parte.cod_musica=musica.codigo 
      		AND musica.cod_artista=artista.codigo
      AND album.nome = n_album
      group by artista.nome_artista;
END;$$;


-- QUESTÃO 12

CREATE or replace FUNCTION lancamento_album()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
DECLARE 
    qtde_musica INTEGER;
BEGIN

        SELECT COUNT(cod_musica) into qtde_musica
        from faz_parte, album, musica, artista
        WHERE faz_parte.cod_album = album.codigo 
        AND faz_parte.cod_musica=musica.codigo
        AND musica.cod_artista=artista.codigo
        and cod_album=new.cod_album
        group by faz_parte.cod_album;
        if qtde_musica >=5 THEN
        	update album set pode_lancar = true WHERE album.codigo = new.cod_album;   
        end if;

    return NULL;
END;$$;

CREATE or replace TRIGGER libera_album
AFTER INSERT or UPDATE ON faz_parte
FOR EACH ROW
EXECUTE PROCEDURE lancamento_album();

DROP TRIGGER libera_album on faz_parte;

INSERT into faz_parte VALUES (2,1);
INSERT into faz_parte VALUES (7,1);

SELECT * from album where pode_lancar = TRUE


-- QUESTÃO 13















