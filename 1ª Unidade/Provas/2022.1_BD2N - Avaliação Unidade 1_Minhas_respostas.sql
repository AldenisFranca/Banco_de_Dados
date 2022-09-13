create table produto (
codigo integer PRIMARY key,
descricao varchar(30) not null,
volume varchar(30),
marca varchar(30),
estoque integer not null,
classificacao_etaria integer,
categoria varchar(20)
);
create table cliente (
id integer PRIMARY key,
nome varchar(40) NOT NULL,
dt_nascimento date NOT NULL,
sexo char,
tipo varchar(20)
);
create table entradas (
cod_produto integer,
lote integer,
quantidade integer not null,
preco_unitario decimal (8,2) not null,
dt_entrada DATE,
primary key (cod_produto, lote),
FOREIGN key (cod_produto) REFERENCES produto (codigo)
);
create table saidas (
cod_produto integer,
id_cliente integer,
dt_saida DATE,
preco_venda decimal (8,2) NOT NULL,
quantidade integer NOT NULL,
PRIMARY key (cod_produto,id_cliente,dt_saida),
FOREIGN key (cod_produto) REFERENCES produto (codigo),
FOREIGN key (id_cliente) REFERENCES cliente (id)
);

INSERT INTO produto values
(1, 'Agua Mineral', '500ml', 'Indaiá', 966, null, 'Bebida'), (2, 'Agua Mineral', '20l', 'Indaiá', 115, 0, 'Bebida'),(3, 'Cerveja lata 350ml', 'Pack com 12', 'Skol', 100, 18, 'Alcoólico'), (4, 'Vodca', '1L', 'Slova', 218, 18,
'Alcoólico'),
(5, 'Coca-cola', '2,5l','Coca-cola', 0, null, 'Refrigerante'), (6, 'Gelo em cubo', 'saco 10kg',null, 161, 0,
'Acompanhamento'),
(7, 'Cerveja long neck', 'Pack com 6','Budweiser', 167, 18, 'Alcoólico'),
(8, 'Cerveja lata 350ml', 'Pack com 12', 'Bohemia', 0, 18, 'Alcoólico'), (9, 'Fanta', '2l','Coca-cola', 507, null,
'Refrigerante');
insert into cliente VALUES
(1, 'Maria do Socorro', '1989-09-29', 'F', 'VIP'), (2, 'Tiago Sales', '2004-08-23', 'M', 'VIP'),
(3, 'Gildo Bezerra', '1992-04-06', 'M', 'Comum'), (4, 'Suellen Barboza', '2004-10-30', 'F', 'Comum'),
(5, 'Lourenço Chagas', '1996-03-25', 'M', NULL);
insert into saidas VALUES
(1,2,'2022-02-01',1.36,50),(1,1,'2022-01-29',1.87,40),(1,1,'2022-02-04',1.69,90),(1,5,'2022-03-25',1.41,200),
(2,3,'2022-03-09',4.97,10),(2,3,'2022-03-28',5,8),(2,3,'2022-04-10',5.10,8), (4,3,'2022-03-20',17.96,48),
(4,3,'2022-03-30',18,50),
(4,1,'2022-03-20',18.69,10),(4,1,'2022-04-30',18.69,7),(4,5,'2022-04-20',19.69,12),
(2,5,'2022-04-10',5.10,14),(2,4,'2022-04-11',5.10,10),(2,3,'2022-04-20',5.25,3),
(6,1,'2022-03-10',8.96,10),(6,3,'2022-03-10',8.96,15),(6,1,'2022-04-12',9,14),
(9,4,'2022-03-20',5.96,10),(9,5,'2022-03-23',6,15),(9,1,'2022-03-27',6.36,8);
insert into entradas VALUES
(1,890,100,0.24,'2022-01-21'),(1,789,410,0.25,'2022-02-01'),(4,6985,200,10.63,'2022-03-15'),
(4,2547,145,9.99,'2022-05-04'),
(1,696,600,0.23,'2022-02-17'),(1,245,236,0.24,'2022-03-25'),(6,879,100,2.35,'2022-03-02'),
(6,587,100,3.65,'2022-03-28'),
(2,748,36,1.68,'2022-03-01'),(2,874,62,1.43,'2022-03-15'),(2,126,70,1.90,'2022-04-02'),
(3,471,100,8.63,'2022-05-01'),(7,123,36,4.69,'2022-03-25'),(7,489,59,5,'2022-03-25'),(7,698,47,5.32,'2022-03-25'),
(7,147,25,4.98,'2022-03-25'),(9,748,300,2.36,'2022-02-01'),(9,874,100,2.47,'2022-03-01'),
(9,369,140,1.99,'2022-04-01');


-- RESOLUÇÃO

/* Criar um relatório com o valor gasto em saídas por tipo de cliente e por categoria de produto.*/
CREATE or REPLACE view VW_gasto_cliente_produto AS
SELECT cliente.tipo, produto.categoria, SUM(saidas.preco_venda*saidas.quantidade), saidas.id_cliente
from saidas, cliente, produto
WHERE saidas.id_cliente = cliente.id and saidas.cod_produto = produto.codigo
group by cliente.tipo, produto.categoria, saidas.id_cliente;

/*Criar um relatório que apresente o nome dos produtos, a quantidade em estoque, o quanto já se gastou com suas entradas e o quanto já se arrecadou com suas saídas.
Além disso, deve calcular qual o valor do lucro/prejuízo (CÁLCULO: quanto se recebeu - quanto se gastou) com esse produto.*/

CREATE or REPLACE view VW_lucro_prejuizo AS
SELECT produto.descricao, produto.estoque, sum(entradas.quantidade*entradas.preco_unitario) as gasto_entrada, 
sum(saidas.quantidade*saidas.preco_venda) as gasto_venda,
sum((saidas.quantidade*saidas.preco_venda) - (entradas.quantidade*entradas.preco_unitario)) as lucro_prejuízo
from produto, entradas, saidas
WHERE produto.codigo = entradas.cod_produto and produto.codigo = saidas.cod_produto and entradas.cod_produto = saidas.cod_produto 
GROUP by produto.descricao, produto.estoque

/*Criar um relatório que apresente o nome do cliente, o nome do produto,
a data, a quantidade e o valor total das saídas registradas no sistema.*/

CREATE or REPLACE view VW_consumo_cliente AS
SELECT cliente.nome, produto.descricao, saidas.dt_saida, saidas.quantidade, SUM(saidas.preco_venda*saidas.quantidade) as valor_saida
from cliente, produto, saidas
WHERE cliente.id = saidas.id_cliente and produto.codigo = saidas.cod_produto 
GROUP by cliente.nome, produto.descricao, saidas.dt_saida, saidas.quantidade ORDER by cliente.nome

/*Criar um relatório que exiba os nomes dos produtos que nunca foram vendidos e o preço gasto em suas entradas.*/

CREATE or REPLACE view VW_nao_vendidos AS
SELECT produto.descricao, sum(entradas.quantidade*entradas.preco_unitario) as preco_gasto
FROM saidas
right join produto on produto.codigo = saidas.cod_produto
RIGHT JOIN entradas on entradas.cod_produto = produto.codigo
WHERE saidas.quantidade is NULL
GROUP by produto.descricao

/*Criar um subprograma que atualize o estoque de todos os produtos de
uma categoria passada como parâmetro. A quantidade do estoque deve
ser atualizada com a soma de todas as quantidades das entradas
subtraída da soma de todas as quantidades das saídas do produto.*/

CREATE or replace procedure atualizar_estoque(nome_categoria TEXT)
LANGUAGE PLPGSQL AS $$
DECLARE
	qtd_entrada integer;
    qtd_saida integer;
begin
	select sum(quantidade) from entradas, produto WHERE entradas.cod_produto = produto.codigo and nome_categoria = produto.categoria into qtd_entrada;
	select sum(quantidade) from saidas, produto WHERE saidas.cod_produto = produto.codigo and nome_categoria = produto.categoria into qtd_saida;
    
    UPDATE produto set estoque = qtd_entrada - qtd_saida WHERE nome_categoria = produto.categoria;
end;$$;

call atualizar_estoque('Refrigerante')


/*Criar um subprograma que retorne o catálogo contendo o nome, a
marca, a quantidade em estoque e a classificação etária dos produtos
de uma categoria passada como parâmetro. Caso a categoria não exista,
deve levantar um erro.*/

CREATE or replace FUNCTION retorna_catalogo(nome_categoria TEXT)
RETURNS table (descricao varchar(30), marca varchar(30), estoque integer, classificacao_etaria integer)
LANGUAGE PLPGSQL AS $$
DECLARE
	existe_cat TEXT;
BEGIN
	SELECT categoria FROM produto WHERE categoria = nome_categoria into existe_cat;
    if (existe_cat is NULL) THEN
    	RAISE EXCEPTION 'Categoria não existe';
    ELSE
    	RETURN QUERY SELECT p.descricao, p.marca, p.estoque, p.classificacao_etaria 
        FROM produto p WHERE categoria = nome_categoria;
    END if;
END;$$;

SELECT * from retorna_catalogo('Alcoólico');


/* Criar um subprograma que retorne a quantidade de produtos de uma
categoria que deram entrada de uma data específica. Caso não tenha
havido entrada nessa data para essa categoria, deve retornar um erro. */

CREATE or replace FUNCTION quantidade_produtos(data_entrada DATE)
RETURNS integer
LANGUAGE PLPGSQL AS $$
DECLARE
	existe_data TEXT;
    qtd_produtos INTEGER;
BEGIN
	SELECT dt_entrada FROM entradas WHERE dt_entrada = data_entrada into existe_data;
    if (existe_data is NULL) THEN
    	RAISE EXCEPTION 'Não houve entrada de produto nesta data';
    ELSE
    	SELECT sum(e.quantidade) FROM entradas e WHERE e.dt_entrada = data_entrada into qtd_produtos;
    END if;
    RETURN qtd_produtos;
END;$$;

SELECT quantidade_produtos('2022-03-25');


/* Criar um subprograma que retorne a quantidade de produtos de uma
categoria que deram entrada de uma data específica. Caso não tenha
havido entrada nessa data para essa categoria, deve retornar um erro. */

CREATE or replace FUNCTION quantidade_produtos(data_entrada DATE, nome_categoria TEXT)
RETURNS integer
LANGUAGE PLPGSQL AS $$
DECLARE
	existe_data TEXT;
    qtd_produtos INTEGER;
BEGIN
	SELECT dt_entrada FROM entradas e, produto p
    WHERE e.cod_produto = p.codigo AND dt_entrada = data_entrada 
    and p.categoria = nome_categoria into existe_data;
    
    if (existe_data is NULL) THEN
    	RAISE EXCEPTION 'Não houve entrada de produto nesta data';
    ELSE
    	SELECT sum(e.quantidade) FROM entradas e, produto p
        WHERE e.cod_produto = p.codigo AND e.dt_entrada = data_entrada and p.categoria = nome_categoria 
        into qtd_produtos;
    END if;
    RETURN qtd_produtos;
END;$$;

SELECT quantidade_produtos('2022-03-25','Alcoólico');


/* TRIGGER 1
Uma regra desse negócio é que a cada entrada de um produto, a quantidade de estoque deve ser
incrementada pela quantidade adquirida.

Criar uma trigger que após o registro da entrada de um produto,
deve ser incrementar o valor do estoque com a quantidade registrada na
entrada. */

CREATE or replace FUNCTION atualiza_estoque()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
BEGIN
	UPDATE produto SET estoque = estoque + new.quantidade where codigo=new.cod_produto;
    RETURN NEW;
end;$$;

CREATE or replace TRIGGER incrementa_estoque
AFTER insert or UPDATE ON entradas
FOR EACH ROW
EXECUTE PROCEDURE atualiza_estoque();

INSERT into entradas VALUES (5,1018,350,8.00,'2022-05-12');


/*TRIGGER 2
Outra regra desse negócio é que as saídas dos produtos só devem acontecer houver estoque do
produto suficiente para atender à quantidade solicitada. Caso tenha estoque suficiente, deve ainda
atualizar o estoque do produto decrementando da quantidade solicitada na saída.
Então, solicito:

Criar uma trigger que só permite a realização de uma saída quando há
estoque disponível para a quantidade desejada. Caso não tenha, deve
bloquear o registro da saída; caso tenha, deve decrementar o estoque
do produto com a quantidade retirada.*/

CREATE or replace FUNCTION atualiza_venda()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
DECLARE
	qtd_disponivel INTEGER;
BEGIN
	SELECT estoque FROM produto WHERE codigo = new.cod_produto into qtd_disponivel;
    if qtd_disponivel < new.quantidade THEN
    	RAISE EXCEPTION 'Quantidade disponível insuficiente!';
    ELSE
	UPDATE produto SET estoque = estoque - new.quantidade where codigo = new.cod_produto;
    end if;
    RETURN NEW;
end;$$;

CREATE or replace TRIGGER decrementa_estoque
BEFORE insert or UPDATE ON saidas
FOR EACH ROW
EXECUTE PROCEDURE atualiza_venda();

INSERT into saidas VALUES (3,1,'2022-05-12',7.50,100);


/* TRIGGER 3
A última regra desse negócio é que a compra de produtos da categoria alcoólicas não seja realizada por
clientes menores de 18 anos.
OBS: para calcular idade a partir de uma data, usar: "extract (year from age(campo_tipo_data))"
Então, solicito:

(EXTRA) Criar uma trigger que antes de cada saída de produto, verifica
se o cliente que está associado à saída é de maior. Caso o cliente não
seja de maior, deve ser proibida à venda, ou seja, deve bloquear o
registro dessa saída.*/

CREATE or replace FUNCTION bloqueia_menoridade()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
DECLARE
	idade_cliente INTEGER;
    class_etaria INTEGER;
BEGIN
	SELECT extract(year from age(dt_nascimento)) FROM cliente WHERE id = new.id_cliente into idade_cliente;
    SELECT classificacao_etaria FROM produto WHERE codigo = new.cod_produto into class_etaria;
    if idade_cliente < 18 and class_etaria = 18 THEN
    	RAISE EXCEPTION 'Venda Proibida de Álcool para menores de 18 anos!';
    end if;
    RETURN NEW;
end;$$;

CREATE or replace TRIGGER verifica_maioridade
BEFORE insert or UPDATE ON saidas
FOR EACH ROW
EXECUTE PROCEDURE bloqueia_menoridade();

INSERT into saidas VALUES (4,4,'2022-05-12',17.50,10);

