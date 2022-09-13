-- Questão 2
CREATE or replace FUNCTION atualizar_times()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN

update times set gols_afavor=gols_afavor+new.gols_mandante, gols_sofridos=gols_sofridos+new.gols_visitante 
	where id=new.id_mandante;
update times set gols_afavor=gols_afavor+new.gols_visitante, gols_sofridos=gols_sofridos+new.gols_mandante 
	where id=new.id_visitante;
    
if new.gols_mandante = new.gols_visitante THEN
	update times set empates = empates+1, num_pontos=num_pontos+1 where id=new.id_mandante or id=new.id_visitante;


elseif new.gols_mandante > new.gols_visitante THEN
  update times set vitorias=vitorias+1, num_pontos=num_pontos+3 where id=new.id_mandante;
  update times set derrotas=derrotas+1 where id=new.id_visitante;

ELSE
  update times set vitorias=vitorias+1, num_pontos=num_pontos+3 where id=new.id_visitante;
  update times set derrotas=derrotas+1 where id=new.id_mandante;
end if;


    
return new;
END; $$;

CREATE or replace TRIGGER tr_empate
after insert ON jogos
FOR EACH ROW
EXECUTE PROCEDURE atualizar_times();

------------------
-- Questão 3
create view classificacao as
select nome, num_pontos, vitorias, (gols_afavor-gols_sofridos) as saldo_gols 
from times
order by num_pontos desc, vitorias desc, saldo_gols desc;

select * from classificacao;

------------------
-- Questão 4
CREATE or replace PROCEDURE inserir_time (nome_time text)
LANGUAGE PLPGSQL AS $$
DECLARE
var_novoID INTEGER;
begin
	select max(id)+1 from times INTO var_novoID;
	insert into times(id,nome, num_pontos,vitorias,derrotas,empates,gols_afavor,gols_sofridos) 
        values (var_novoID,nome_time,0,0,0,0,0,0);
    --insert into times(id,nome, num_pontos,vitorias,derrotas,empates,gols_afavor,gols_sofridos) 
        --values ((select max(id)+1 from times),nome_time,0,0,0,0,0,0);
end;$$;

call inserir_time ('Salgueiro');
select * from times;

------------------
-- Questão 5
CREATE or replace FUNCTION diferenca_times ( )
returns integer
LANGUAGE PLPGSQL AS $$
DECLARE
	diferenca INTEGER;
begin
	select Max(num_pontos) - min(num_pontos) from times into diferenca;
    RETURN diferenca;
end;$$;

select diferenca_times();


------------------
-- Questão 6
CREATE or replace procedure cadastrar_jogo (nome_mandante text, nome_visitante text, g_mandante integer, g_visitante integer )
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

call cadastrar_jogo('Náutico', 'Retrô',1,3);
select * from times;