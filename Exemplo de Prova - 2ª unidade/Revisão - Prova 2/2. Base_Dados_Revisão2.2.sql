CREATE TABLE area ( 
	codigo int primary key ,
	descricao varchar (30),
	predio varchar (40)
);
CREATE TABLE curso (
	codigo int primary key ,
	nome varchar (40) not null,
	cod_area int,
	vagas integer,
	nome_coordenador varchar(50),
	foreign key (cod_area) 
                     references area (codigo)	
);

CREATE TABLE aluno (
	matricula int primary key ,
	nome varchar (50) not null,
	cidade_endereco varchar (30),
	telefone int,
	mensalidade decimal (6,2),
	media_notas decimal (3,1) not null,
	data_nascimento date,
	cod_curso int not null,
	foreign key (cod_curso) 
	       references curso (codigo)
);
insert into area values
  (1,"Exatas", "Bloco C"), (2,"Saúde", "Bloco B"),
  (3,"Humanas", "Bloco A");

insert into curso values
  (1,"Informatica para Internet", 1, 20, "Francisco"),
  (2,"Nutrição", 2, 25, null),
  (3,"Enfermagem", 2, 30, "Maria"),
  (4,"Ciências da Computação", 1, 30, null),
  (5,"Redes de Computadores", 1, 20, "Zilmara"),
  (6,'Odontologia', null, 18, null);

INSERT INTO aluno  values
  (1,"Mariana Torres", "Recife",   null, 815.78, 8.9, '1998-10-19', 1), 
  (2,"Carolina Pereira", "Olinda", 982736410, 726.37, 7.5, null, 1), 
  (3,"Adriano Freire", "Palmares", NUll, 982.62, 5.2, '1994-07-05', 5), 
  (4,"Elaine Villas", "Olinda",    902816253, 856.01, 5.8, '2000-04-29', 3),
  (5,"Paulo Veras", "Olinda", 976253123, 582.71, 6.3, '1988-03-30', 3),
  (6,"Talita Veiga", "Jaboatão", 952434172, 837.29, 8.7, '1990-11-23', 4), 
  (7,"Katia Garcia", "Palmares", 962534122, 526.62, 9.7, '1991-10-19', 5), 
  (8,"Júlio Mercedes", "Palmares", null, 837.73, 7.6, null, 3), 
  (9,"Fátima Silva", "Jaboatão",   981722639, 549.91, 9.4, '1986-09-04', 5);
