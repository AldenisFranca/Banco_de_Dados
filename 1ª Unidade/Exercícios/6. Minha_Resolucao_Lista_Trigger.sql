create table times (
id serial primary key,
nome varchar(30) not null,
num_pontos integer,
vitorias integer,
derrotas integer,
empates integer,
gols_afavor integer,
gols_sofridos integer
);

insert into times values
(1,'Sport',0,0,0,0,0,0),
(2,'Náutico',0,0,0,0,0,0),
(3,'Santa Cruz',0,0,0,0,0,0);

create table jogos (
id_mandante integer,
id_visitante integer,
gols_mandante integer,
gols_visitante integer,
PRIMARY key
(id_mandante, id_visitante),
FOREIGN key(id_mandante) REFERENCES times (id),
FOREIGN key(id_visitante) REFERENCES times (id)
);

-- -----------------------------------------------------------------------------------

-- 1ª: 1.Atualizar a função atualizar_time() para todas as atualizações necessárias listadas abaixo:
-- Se a partida houver um vencedor, atualizar a quantidade de derrotas e de vitórias;

CREATE or replace FUNCTION atualizar_empate()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN

if new.gols_mandante= new.gols_visitante THEN
	update times set empates = empates+1 where id=new.id_mandante or id=new.id_visitante;
elseif new.gols_mandante > new.gols_visitante THEN
	update times set vitorias=vitorias+1 where id=new.id_mandante;
	update times set derrotas=derrotas+1 where id=new.id_visitante; 
ELSE
    update times set vitorias=vitorias+1 where id=new.id_visitante;
    update times set derrotas=derrotas+1 where id=new.id_mandante;
end if;

return new;
END; $$;

CREATE or replace TRIGGER tr_empate
after insert ON jogos
FOR EACH ROW
EXECUTE PROCEDURE atualizar_empate();

-- 2ª: É necessário contabilizar as informações de gols sofridos e feitos, além de atualizar a pontuação dos times após um jogo
-- ser realizado, seguindo as seguintes regras:
-- - Atualizar as informações de gols pro e gols contra;
-- - Atualizar a pontuação dos times de acordo com a situação abaixo:
-- 		•Vencedor: +3 pontos
-- 		•Empate: +1 ponto para cada time
-- 		•Perdedor: não altera a pontuação

CREATE or replace FUNCTION atualizar_times()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN

if new.gols_mandante = new.gols_visitante THEN
  update times set empates = empates+1, num_pontos = num_pontos+1 where id=new.id_mandante or id=new.id_visitante;

elseif new.gols_mandante > new.gols_visitante THEN
  update times set vitorias=vitorias+1, num_pontos = num_pontos+3 where id=new.id_mandante;
  update times set derrotas=derrotas+1 where id=new.id_visitante;

ELSE
  update times set vitorias=vitorias+1, num_pontos = num_pontos+3 where id=new.id_visitante;
  update times set derrotas=derrotas+1 where id=new.id_mandante;

end if;

UPDATE times set gols_afavor = gols_afavor + new.gols_mandante, gols_sofridos = gols_sofridos + new.gols_visitante WHERE id=new.id_mandante;
UPDATE times set gols_afavor = gols_afavor + new.gols_visitante, gols_sofridos = gols_sofridos + new.gols_mandante WHERE id=new.id_visitante;

return new;
END; $$;

CREATE or replace TRIGGER tr_times
after insert ON jogos
FOR EACH ROW
EXECUTE PROCEDURE atualizar_times();

-- Inserindo os jogos para conferir a trigger:

INSERT into jogos VALUES (3,1,1,0);
INSERT into jogos VALUES (1,3,4,4);

SELECT * from times;

-- 3ª: Crie uma visão para identificar a classificação do campeonato, que deve seguir as seguintes regras de ordenação:
-- pontuação, número de vitórias e saldo de gols.

CREATE or REPLACE VIEW VW_CLASSIFICACAO AS
SELECT nome, num_pontos as Pontuação, vitorias as Número_Vitórias, (gols_afavor - gols_sofridos) as Saldo_Gols
from times
ORDER by 2 DESC, 3 DESC, 4 DESC;

SELECT * FROM VW_CLASSIFICACAO;

-- 4ª:Crie um subprograma que insere um time recebendo apenas o nome do time como argumento 
-- e defina o número de ID que deve ser utilizado e inicializando com 0 os demais atributos.

CREATE or replace PROCEDURE inserir_time (nome_time text)
LANGUAGE PLPGSQL AS $$
DECLARE
var_novoID INTEGER;
begin
	select max(id)+1 from times INTO var_novoID;
	insert into times(id, nome, num_pontos, vitorias, derrotas, empates, gols_afavor, gols_sofridos) 
    values (var_novoID,nome_time,0,0,0,0,0,0);
    --insert into times(id,nome, num_pontos,vitorias,derrotas,empates,gols_afavor,gols_sofridos) 
    --values ((select max(id)+1 from times),nome_time,0,0,0,0,0,0);
end;$$;

call inserir_time ('Salgueiro');
select * from times;

-- 5ª: Crie um subprograma que retorne a diferença de pontos entre o primeiro e último colocado.

CREATE or replace FUNCTION diff_pontos()
RETURNS INTEGER
LANGUAGE PLPGSQL AS $$
DECLARE
	diferenca INTEGER;
BEGIN
	SELECT max(num_pontos) - MIN(num_pontos) FROM times into diferenca;
    RETURN diferenca;
END; $$;

SELECT diff_pontos();

-- 6ª: Crie um subprograma que recebe o resultado de um jogo entre dois times e realiza a atualização desses dados.

CREATE or replace procedure cadastrar_jogo (nome_mandante text, nome_visitante text, g_mandante integer, g_visitante integer)
LANGUAGE PLPGSQL AS $$
DECLARE
	id_mand integer;
    id_visit integer;
    jogo_existe boolean;
begin
	select id from times where nome=nome_mandante into id_mand;
	select id from times where nome=nome_visitante into id_visit;
    
    if (id_mand is null) THEN
    	raise EXCEPTION 'Mandante não existe';
    ELSEif (id_visit is null) THEN
    	raise EXCEPTION 'Visitante não existe';
    else
    	select True from jogos where id_mandante=id_mand and id_visitante=id_visit INTO jogo_existe;
        if jogo_existe is NULL THEN
    		insert into jogos values (id_mand,id_visit,g_mandante,g_visitante);
        ELSE
        	raise EXCEPTION 'Esse jogo já ocorreu!';
        end IF;
    END IF;
end;$$;

call cadastrar_jogo('Salgueiro', 'Sport',1,3);
select * from times;

-- 7ª: Crie um subprograma que retorne os nomes dos times e a quantidade de pontos ordenados de acordo com o critério escolhido:
-- 1 (qtde de pontos), 2 (qtde de vitórias), ou 3 (saldo de gols). RETURN QUERY

CREATE TYPE type_times_jogos as (
	nome TEXT,
    num_pontos INTEGER
);

CREATE FUNCTION times_jogos()
RETURNS SETOF type_times_jogos AS $$
DECLARE
	dados_times_jogos type_times_jogos; 
BEGIN
	for dados_times_jogos in
        SELECT nome, num_pontos 
        FROM times 
        GROUP by nome, num_pontos, vitorias, (gols_afavor - gols_sofridos)
        ORDER by num_pontos DESC, vitorias DESC, (gols_afavor - gols_sofridos) DESC
        loop RETURN NEXT dados_times_jogos;
    end LOOP;
	RETURN;
END; $$ LANGUAGE PLPGSQL ;

SELECT * FROM times_jogos();


select * from vw_classificacao;
DROP FUNCTION times_jogos();

INSERT into jogos VALUES (1,2,3,2);
INSERT into jogos VALUES (4,3,5,2);

-- 8ª: O sistema agora deve contabilizar em um atributo quantos jogos cada time fez, então solicito:
-- Criar um subprograma que cria a coluna num_jogos do tipo inteiro na tabela time e atualiza o valor
-- dessa coluna com a soma dos valores nos seguintes 3 campos: empates, vitórias e derrotas.

CREATE or replace PROCEDURE inserir_num_jogos ()
LANGUAGE PLPGSQL AS $$
begin
	ALTER TABLE times ADD num_jogos INTEGER;
    UPDATE times SET num_jogos = empates + vitorias + derrotas;
end;$$;

call inserir_num_jogos();
select * from times;

-- 9ª: Executar o subprograma acima, e logo depois deletá-lo.

DROP PROCEDURE inserir_num_jogos;

-- 10ª: O número de jogos de um time deve ser incrementado antes que um jogo que ele participou seja cadastrado no banco. 
-- Criar essa regra de negócio via trigger, lembrando de atualizar a quantidade de jogos dos dois participantes da partida!!

CREATE or replace FUNCTION atualizar_num_jogos()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN
		UPDATE times SET num_jogos = num_jogos + 1 where id=new.id_mandante or id=new.id_visitante;
    RETURN num_jogos;
end;$$;

CREATE or replace TRIGGER tr_num_jogos
BEFORE insert ON jogos
FOR EACH ROW
EXECUTE PROCEDURE atualizar_num_jogos();


INSERT into jogos VALUES (3,1,2,0);
INSERT into jogos VALUES (1,3,3,4);

SELECT * from times;

