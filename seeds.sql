INSERT INTO
	contato (email, celular, telefone, contato)
VALUES
	(
		'pessoafisica@email.com',
		'11999998877',
		NULL,
		NULL
	),
	(
		'pessoajuridica@email.com',
		'11999991122',
		'1155552211',
		'Jhon Doe'
	);

INSERT INTO
	endereco(
		logradouro,
		numero,
		complemento,
		bairro,
		cidade,
		uf,
		cep
	)
VALUES
	(
		'Rua Principal',
		'1',
		NULL,
		'Centro',
		'São Paulo',
		'SP',
		'12345678'
	),
	(
		'Rua Marginal',
		'2',
		'Galpão 5',
		'Casa Verde',
		'São Paulo',
		'SP',
		'87654321'
	);

INSERT INTO
	cliente (tipo, id_contato, id_endereco)
VALUES
	(DEFAULT, 1, 1),
	(DEFAULT, 1, 2),
	(DEFAULT, 1, 1),
	(DEFAULT, 1, 2),
	("PJ", 2, 1),
	("PJ", 2, 2);

INSERT INTO
	pessoa_fisica(nome_completo, cpf)
VALUES
	('João José', '01234567890'),
	('Maria Silva', '12345678901'),
	('Jhonatam Cesar', '78964741072'),
	('Carlos Mecanico', '98413565030'),
	('José Funileiro', '09208854035'),
	('Silvia Eletricista', '06303020062'),
	('Andrea Pintora', '00588668095'),
	('Mariana Souza', '03007420024');

INSERT INTO
	pessoa_fisica_cliente(id_cliente, id_pessoa_fisica)
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4);

INSERT INTO
	pessoa_juridica(razao_social, nome_fantasia, cnpj, ie)
VALUES
	(
		'Empresa Um Ltda',
		'Um Corp',
		'11111111111111',
		'00000000'
	),
	(
		'Empresa Dois Ltda',
		'Grupo Dois',
		'22222222222222',
		NULL
	);

INSERT INTO
	pessoa_juridica_cliente(id_cliente, id_pessoa_juridica)
VALUES
	(5, 1),
	(6, 2);

INSERT INTO
	funcionario(
		codigo_funcionario,
		cargo,
		data_admissao,
		id_pessoa_fisica,
		id_contato,
		id_endereco
	)
VALUES
	('00000001', 'Mecânico', '2020-01-01', 4, 1, 1),
	('00000003', 'Funileiro', '2022-10-05', 5, 1, 1),
	('00000004', 'Eletricista', '2023-12-01', 6, 1, 1),
	('00000005', 'Pintor', '2021-05-21', 7, 1, 1),
	(
		'00000006',
		'Recepcionista',
		'2024-06-01',
		5,
		1,
		1
	);

INSERT INTO
	especialidade(especialidade)
VALUES
	('MECANICA'),
	('FUNILARIA'),
	('ELETRICA'),
	('PINTURA');

INSERT INTO
	funcionario_especialidade(id_funcionario, id_especialidade)
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4);

INSERT INTO
	veiculo(
		modelo,
		fabricante,
		cor,
		ano_modelo,
		ano_fabricacao,
		placa,
		chassi,
		id_cliente
	)
VALUES
	(
		'Fusca',
		'Volkswagen',
		'Preto',
		1969,
		1970,
		'AAA1234',
		'9BGRD08X04G117974',
		1
	),
	(
		'HB20',
		'Hyundai',
		'Prata',
		2022,
		2022,
		'BBB9876',
		NULL,
		2
	),
	(
		'City',
		'Honda',
		'Cinza',
		2013,
		2014,
		'ABC0101',
		'9BD111060T5002156',
		3
	),
	(
		'Civic',
		'Honda',
		'Cinza',
		2020,
		2020,
		'CCC3333',
		'1BD111060T5002157',
		4
	),
	(
		'Gol',
		'Volkswagen',
		'Branco',
		2008,
		2008,
		'DDD4444',
		'2BD111060T5002158',
		5
	),
	(
		'Fiorino',
		'Fiat',
		'Branco',
		2024,
		2024,
		'EEE555',
		'3BD111060T5002159',
		6
	);

INSERT INTO
	ordem_servico(
		status,
		data_emissao,
		data_previsao_conclusao,
		data_conclusao,
		comentario,
		orcamento_aprovado,
		forma_pagamento,
		id_veiculo
	)
VALUES
	(
		"FINALIZADO",
		'2024-10-01 09:02:00',
		'2024-10-05 16:00:00',
		"2024-10-05 11:00:00",
		NULL,
		1,
		"DINHEIRO",
		1
	),
	(
		"OFICINA",
		'2024-10-03 10:00:00',
		'2024-10-04 09:00:00',
		NULL,
		NULL,
		1,
		"PIX",
		2
	),
	(
		"ORCAMENTO",
		'2024-12-26 08:00:00',
		'2024-12-27 17:00:00',
		NULL,
		NULL,
		DEFAULT,
		"PIX",
		3
	),
	(
		"ORCAMENTO",
		DEFAULT,
		'2025-01-03 12:00:00',
		NULL,
		NULL,
		DEFAULT,
		"CREDITO",
		4
	);

INSERT INTO
	peca(descricao, valor, estoque)
VALUES
	('Correia Deantada', 79.98, 10),
	('Óleo Motor', 49.9, 20),
	('Filtro de Óleo', 25, 2),
	('Filtro de Ar', 19.99, 30),
	('Vela de Ignição', 39.5, 2);

INSERT INTO
	ordem_servico_peca(id_ordem_servico, id_peca, valor, quantidade)
VALUES
	(1, 2, 49.9, 5),
	(1, 3, 25, 1),
	(1, 4, 19.9, 1),
	(2, 1, 79.98, 1),
	(2, 5, 39.5, 4);

INSERT INTO
	mao_obra(descricao, valor)
VALUES
	('Troca de Óleo', 100),
	('Troca de Velas', 120),
	('Troca de correa', 200),
	('Ajuste Motor', 120),
	('Scanner', 80);

INSERT INTO
	ordem_servico_mao_obra(id_ordem_servico, id_mao_obra, valor, quantidade)
VALUES
	(1, 1, 100, 1),
	(2, 2, 120, 1),
	(2, 3, 200, 1),
	(2, 4, 120, 1),
	(2, 5, 65, 1);

INSERT INTO
	fornecedor(id_pessoa_juridica, id_contato, id_endereco)
VALUES
	(1, 1, 1),
	(2, 2, 2);

INSERT INTO
	peca_fornecedor(id_peca, id_fornecedor)
VALUES
	(1, 1),
	(2, 2),
	(3, 1),
	(4, 2),
	(5, 1);

INSERT INTO
	funcionario_ordem_servico(id_funcionario, id_ordem_servico)
VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 2);