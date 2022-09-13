/* CÓDIGOS ANTES DE RESPONDER A ATIVIDADE: */

/* Criação das Tabelas: */

CREATE TABLE area(
codigo int primary key,
descricao varchar(30),
predio varchar(40)
);

CREATE TABLE curso (
codigo int primary key,
nome varchar(40) not null,
cod_area int,
nome_coordenador varchar(50),
foreign key(cod_area) references area(codigo)
);

CREATE TABLE aluno (
matricula int primary key,
nome varchar(50) not null,
cidade_endereco varchar(30),
telefone int,
data_nascimento date,
cod_curso int not null,
foreign key(cod_curso) references curso(codigo)
);


/* Inserção de Dados nas Tabelas */

INSERT INTO area values
(1,"Exatas", "Bloco C"), 
(2,"Saúde", "Bloco B"),
(3,"Humanas", "Bloco A");

INSERT INTO curso values
(1,"Informatica para Internet", 1, "Francisco"),
(2,"Nutrição", 2, null),
(3,"Enfermagem", 2, "Maria"),
(4,"Ciências da Computação", 1, null),
(5,"Redes de Computadores", 1, "Zilmara");

INSERT INTO aluno values
(1,"Mariana Torres", "Recife", 934261029, '1998-10-19', 1),
(2,"Carolina Pereira", "Olinda", 982736410, '1999-01-10', 1),
(3,"Adriano Freire", "Palmares", 952351726, '1994-07-05', 5),
(4,"Elaine Villas", "Olinda", 902816253, '2000-04-29', 3),
(5,"Paulo Veras", "Olinda", 976253123, '1988-03-30', 3),
(6,"Talita Veiga", "Jaboatão", 952434172, '1990-11-23', 4),
(7,"Katia Garcia", "Palmares", 962534122, '1991-10-19', 5),
(8,"Júlio Mercedes", "Palmares", 981727263, '1999-01-01', 3),
(9,"Fátima Silva", "Jaboatão", 981722639, '1986-09-04', 5);


/* ATIVIDADE: */

/* 1. Quais os nomes dos alunos que moram em Olinda? */

SELECT nome FROM aluno WHERE cidade_endereco = 'Olinda'

/* 2. Quais as cidades que moram as pessoas que nasceram nos anos 90? */

SELECT cidade_endereco FROM aluno
WHERE data_nascimento BETWEEN '1990-01-01' AND '1999-12-31'

/* 3. Trazer os nomes dos cursos junto com os nomes dos coordenadores ordenados pelo nome do curso. */

SELECT nome, nome_coordenador FROM curso ORDER BY 1

/* 4. Qual os nomes das áreas que possuem curso ainda sem coordenador? */

SELECT descricao FROM area
WHERE codigo IN (SELECT cod_area FROM curso
                 WHERE nome_coordenador IS NULL)
				 
/* 5. Quais os nomes dos alunos que frequentam o curso cujo coordenador é Francisco? */

SELECT nome FROM aluno
WHERE cod_curso IN (SELECT codigo FROM curso
                    WHERE nome_coordenador = 'Francisco')
					
/* 6. Quais as cidades dos alunos que possuem sobrenome começando com a letra V? */

SELECT DISTINCT cidade_endereco FROM aluno WHERE nome LIKE '% V%'

/* 7. Quais os cursos que possuem coordenador e são de Exatas? */

SELECT nome FROM curso 
WHERE cod_area IN (SELECT codigo FROM area
                 WHERE descricao = 'Exatas')
AND nome_coordenador IS NOT NULL