-- Povoamento das Tabelas


-- CONSTRUTORA

INSERT INTO CONSTRUTORA VALUES
(1,11444777000161,'Ramos e Souza S.A.','Objetivo Construtora',1963,29906735,'Rua Alberto Farias',500,'Palmital','Linhares','ES'),
(4,24621401000127,'Nigro LTDA.','VX Buildings',2016,59122405,'Rua do Alvorecer',237,'Redinha','Natal','RN'),
(6,85133837000161,'Arcuri S.A.','Poupe Construções',2013,49043323,'Travessa Q2',5200,'São Conrado','Aracaju','SE'),
(8,02212482000179,'Kahneman Braga S.A.','KB Solutions',2000,57073593,'Avenida Francisco de Holanda',659,'Cidade Universitária','Maceió','AL'),
(9,80161366000181,'Paiva Beça S.A.','Paiva Beça',1996,70350717,'Quadra SHIGS 705 Bloco Q',23,'Asa Sul','Brasília','DF'),
(10,67181109000143,'Grupo TGM S.A.','TGM Buildings',1988,40713510,'Travessa Olímpia',84,'Itacaranha','Salvador','BA'),
(12,84485942000105,'Grupo Imperial LTDA.','Construtudo',2006,88040490,'Rua Rodolfo Manoel Bento',2202,'Trindade','Florianópolis','SC');

INSERT INTO CONSTRUTORA (id,cnpj,razao_social,nome_fantasia,ano_fundacao,cep,numero) VALUES
(2,08406249000103,'Bragança Lopes Edifícios S.A.','Bragança Lopes',1982,57062016,120),
(3,79031801000174,'James Hunter LTDA.','Hunter Construtora',2003,68506747,8729),
(5,28280576000179,'Construtec LTDA.','Construtec',2012,57071104,401),
(7,56691905000100,'Broken Faster S.A.','Buildility',1999,83055380,55),
(11,23051650000161,'Grupo Máxima S.A.','Skyline Contractors',1977,36033490,9);

-- CARGOS 

INSERT INTO CARGOS (cbo, nome, descricao) VALUES
(214205,'Engenheiro civil','Desenvolve projetos.'),
(710205,'Encarregado de Obras','Lê e executa projetos.' ),
(715210,'Pedreiro','Assenta tijolos e afins.'),
(951105,'Eletricista',null),
(142105,'Gerente Administrativo',null),
(724110,'Encanador','Monta sistemas de tubulações.'),
(716610,'Pintor',null),
(724440,'Serralheiro','Executar serviço serralheria'),
(782310,'Motorista',null),
(987654,'Estagiário',null);

-- FUNCIONÁRIOS

INSERT INTO FUNCIONARIOS (nome_completo,rg,cpf,salario,data_nascimento,sexo,matricula,qtd_filhos,id_construtora,cbo_cargos,matr_supervisiona) VALUES
('Marcelo Bezerra da Silva',8025305,35312564505,6358.17,'1981-07-20','M',68222,3,5,214205,null),
('Adriano Candal Matos',394664516,05361844101,5370.00,'2000-04-17','M',79046,0,5,710205,68222),
('Sávio Farias Rezende',348767407,46136784203,13102.85,'1968-05-29','M',88246,4,2,214205,null),
('Olga Castanho Pestana',210651416,37838835712,2546.37,'1987-12-08','F',76417,2,2,716610,88246),
('Adriele Pais Póvoas',331135036,01651314209,2479.25,'1994-05-18','F',76357,2,11,724110,null),
('Elielson Anjos Frossard',170646415,41135472203,8668.50,'1985-07-04','M',93480,3,7,214205,null),
('Lucas Felipe Consendey Falcão',398541930,65883037186,3324.68,'1998-05-05','M',51411,1,9,951105,null),
('Domingos Ascar Vasgestian',427791170,32217766830,2100.45,'1992-06-18','M',95837,4,1,715210,null),
('Severino Ervano Carmoriz',258247320,11286563291,3335.18,'1977-08-07','M',30498,5,2,715210,88246),
('Joemia Marins da Silva',223792767,20482242299,4588.96,'1996-09-11','F',37823,3,6,142105,null),
('Lucas Emanuel Reis Auzier',460875255,12721933302,2566.74,'1999-07-07','M',55557,2,12,951105,null),
('Emanuele Pereira da Silva',7076095,32565214535,5023.18,'1983-06-12','F',59632,4,8,142105,null),
('Bernardo Guedes Germano',231271165,76175438167,2200.58,'2002-10-30','M',48142,1,8,715210,59632),
('Flávio Cabral de Melo',2531861,23562114212,2507.09,'1986-11-25','M',78425,3,11,951105,null),
('Paulo Felipe Silva Bezerra',7075099,05466535212,2790.63,'1981-03-11','M',93244,2,2,715210,88246),
('Elisabeth França Lins',7536025,35415363515,1800.00,'2003-02-15','F',98236,0,6,987654,null),
('Juan Knupp Anastacio',225884549,73377450521,2188.74,'1993-01-08','M',67206,2,9,782310,51411),
('Geraldo Lourenço Rezende',25265528,13054913511,2566.19,'1990-11-26','M',75474,1,12,724440,55557),
('Caleb Vitorino Dores',461215317,55533923306,3321.41,'1977-10-16','M',66566,3,10,710205,null),
('Milena da Silva Medeiros',342184349,48984341185,1750.00,'1985-07-19','F',64583,2,10,987654,66566);

-- TELEFONES_FUNCIONARIOS

INSERT into TELEFONES_FUNCIONARIOS (matr_funcionario,num_telefone) VALUES
(79046,9234134112),(79046,46984091221),(79046,55993462479),(76417,38950352124),(76417,59988078828),(76357,85967842733),
(93480,89932711982),(93480,41955973592),(30498,89929673912),(37823,24905271826),(37823,36920696587),(66566,21932621806),
(64583,16983022351),(64583,53975107069),(64583,53974374902),(64583,30999986640),(75474,83913119690),(78425,57997926346),
(98236,27972444874),(67206,34924484798),(67206,34938128910),(95837,89933401058),(51411,87978995388),(93244,89984237470);

-- TELEFONES_CONSTRUTORA

INSERT INTO TELEFONES_CONSTRUTORA (id_construtora,num_telefone) VALUES
(1,2233491480),(1,6825674960),(2,8335075820),(3,3224182472),(3,7423327237),(3,6431382835),(5,6732172834),(5,3125375169),
(6,9321887814),(7,9525181423),(7,8427700060),(8,6926371174),(8,9836014368),(8,8923788620),(10,8233663633),(11,3427253871),
(11,8739341559),(12,9932545716),(12,9629044085);

-- FORNECEDORES

INSERT INTO FORNECEDORES (cnpj,razao_social,matricula,material_fornecido) VALUES
(76327991000183,'Lorenzetti S.A.',25252,'Luminárias'),
(02117255000164,'Connect Cimentos Ltda.',70198,'Cimento, argamassa e rejunte'),
(93353040000106,'Radial S.A.',94080,'Tilojos e blocos'),
(49259971000140,'Krona Tubos e Conexões S.A.',31780,'Tubulações Hidráulicas'),
(70823638000108,'Stam Ltda.',16021,'Areia, brita e concreto'),
(51906886000178,'Shirley Venoso Ltda.',47342,'Fechaduras'),
(80765170000104,'ConstruLar Brasil S.A.',29325,'Ferragens e Ferramentas'),
(47201534000140,'Signature Materiais S.A.',78956,null),
(93876400000146,'Genius S.A.',33158,'Tintas'),
(45726297000105,'Rede Construir Materiais S.A.',24857,null),
(96403265000100,'Copafer Comercial S.A.',45187,'Pisos e revestimentos'),
(37875731000190,'HN Construções Ltda.',34162,null),
(92037790000106,'Mega Engenharia Ltda.',96321,'Fios elétricos'),
(48540429000106,'CasaBella Acabamentos S.A.',33230,'Louças Sanitárias');
  
-- POSSUI

INSERT INTO POSSUI (id_construtora,matr_fornecedor) VALUES
(1,25252),(1,96321),(2,70198),(3,47342),(5,31780),(6,45187),(6,96321),(7,33158),(9,33158),
(9,16021),(10,33230),(11,25252),(12,94080),(12,70198),(12,45187);

-- MATERIAIS_FORNECIDOS
  
INSERT INTO MATERIAIS_FORNECIDOS (id_construtora,matr_fornecedor,nome,valor) VALUES
(1,25252,'Luminárias',10500.00),(1,96321,'Fio elétrico',20000.00),(2,70198,'Cimento',200000.00),
(2,70198,'Argamassa',100000.00),(2,70198,'Rejunte',70000.00),(3,47342,'Fechaduras',4500.00),
(5,31780,'Tubos de PVC',22354.12),(5,31780,'Tubos de aço',36541.95),(6,45187,'Pisos',12478.33),
(6,96321,'Fio elétrico',10000.00),(7,33158,'Tinta',9548.15),(9,33158,'15000 litros de tinta',15784.19),
(9,16021,'Areia',26115.96),(10,33230,'Louças Sanitárias',59971.00),(11,25252,'Luminárias',15000.00),
(12,94080,'Tijolos',30785.37),(12,70198,'Cimento',21669.84),(12,45187,'Revestimento',29108.79),
(12,94080,'Blocos de concreto',1308.62);




