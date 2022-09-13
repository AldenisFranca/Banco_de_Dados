-- 1
CREATE or replace PROCEDURE altera_nome_produto (novo_nome_produto TEXT, produto_cod integer)
LANGUAGE PLPGSQL AS $$
DECLARE
  prod_nome varchar(30);
begin
   select nome_produto from produto where cod_produto = produto_cod INTO prod_nome;
   if prod_nome is null THEN
   		RAISE EXCEPTION 'Código de produto inválido';
   ELSE
   		UPDATE produto set nome_produto = novo_nome_produto WHERE cod_produto = produto_cod;
   end if;
end;$$;

-- 2
call altera_nome_produto('Creta', 2);
SELECT * from produto;

-- 3
drop PROCEDURE altera_nome_produto(text, INTEGER);

-- 4
CREATE OR REPLACE FUNCTION insere_relacao(produto_cod INTEGER, fornecedor_cod INTEGER)
RETURNS TEXT
LANGUAGE PLPGSQL AS $$
DECLARE
	existe_prod INTEGER;
    existe_forn INTEGER;
   	existe_relacao BOOLEAN;
    texto text;
bEGIN
	SELECT cod_produto from produto WHERE cod_produto = produto_cod into existe_prod;
    SELECT cod_fornecedor from fornecedor WHERE cod_fornecedor = fornecedor_cod into existe_forn;  
    if (existe_forn is NULL or existe_prod is NULL) THEN
    	raise EXCEPTION 'Produto e/ou Fornecedor inexistente!';
    ELSE
    	SELECT TRUE from forn_prod WHERE cd_produto = existe_prod and cd_fornecedor = existe_forn into existe_relacao;
    	if (existe_relacao is NULL) THEN
	    INSERT into forn_prod VALUES (fornecedor_cod, produto_cod);
            texto = 'Relação adicionada';
        ELSE
            raise EXCEPTION 'Relação entre produto e fornecedor já existe!';
       end IF;
    return texto;
	end IF;
END;$$;

SELECT insere_relacao(3,3);

-- 5
CREATE or replace PROCEDURE cadastro_completo(produto_novo TEXT, preco_novo DECIMAL, categoria_nova text, setor_novo text, fornecedor_novo TEXT)
LANGUAGE PLPGSQL AS $$
DECLARE
	next_cod_setor INTEGER;
	next_cod_forn INTEGER;
    next_cod_prod INTEGER;
begin
	SELECT max(cod_setor) FROM setor into next_cod_setor;
	INSERT into setor(cod_setor, nome_setor) VALUES (next_cod_setor + 1, setor_novo);
    
    SELECT max(cod_fornecedor) FROM fornecedor into next_cod_forn;
    INSERT into fornecedor(cod_fornecedor, nome_fornecedor) VALUES (next_cod_forn + 1, fornecedor_novo);
    
    SELECT max(cod_produto) FROM produto into next_cod_prod;
	INSERT into produto (cod_produto, nome_produto, preço, categoria, cd_setor) VALUES (next_cod_prod + 1, produto_novo, preco_novo, categoria_nova, next_cod_setor + 1);
    
    INSERT INTO forn_prod VALUES (next_cod_forn + 1, next_cod_prod + 1);
end;$$;

-- 6
CALL cadastro_completo('livro', 49.90, 'Livros escolares', 'Papelaria', 'Saraiva');
SELECT * from produto;


-- 7
CREATE OR REPLACE FUNCTION verifica_idade(idade INTEGER)
RETURNS BOOLEAN
LANGUAGE PLPGSQL AS $$
bEGIN
    if (idade >= 18) THEN
    	RETURN TRUE;
    ELSE
    	RETURN FALSE;
	end IF;
END;$$;

SELECT verifica_idade(17);

-- 8
CREATE OR REPLACE FUNCTION verifica_pessoa(nome_pessoa TEXT, idade INTEGER)
RETURNS TEXT
LANGUAGE PLPGSQL AS $$
DECLARE
	maioridade BOOLEAN;
bEGIN
	SELECT verifica_idade(idade) into maioridade;
    if maioridade is true THEN
    	RETURN 'Esta pessoa é de maior!';
    ELSE
    	RETURN 'Esta pessoa é de menor!';
	end IF;
END;$$;

SELECT verifica_pessoa('xola', 18);

