CREATE DATABASE IF NOT EXISTS oficina_mecanica;

USE oficina_mecanica;

CREATE TABLE IF NOT EXISTS contato(
    id_contato INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(120),
    celular CHAR(11),
    telefone CHAR(10),
    contato VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS endereco(
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(120) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(80) NOT NULL,
    cidade VARCHAR(80) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL
);

CREATE TABLE IF NOT EXISTS cliente(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM("PF", "PJ") DEFAULT "PF",
    id_contato INT NOT NULL,
    id_endereco INT NOT NULL,
    CONSTRAINT fk_cliente_contato FOREIGN KEY (id_contato) REFERENCES contato(id_contato),
    CONSTRAINT fk_cliente_endereco FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE IF NOT EXISTS pessoa_fisica(
    id_pessoa_fisica INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(120) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS pessoa_fisica_cliente(
    id_cliente INT NOT NULL,
    id_pessoa_fisica INT NOT NULL,
    CONSTRAINT fk_pessoa_fisica_cliente_cliente_id FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    CONSTRAINT fk_pessoa_fisica_cliente_pessoa_fisica_id FOREIGN KEY (id_pessoa_fisica) REFERENCES pessoa_fisica(id_pessoa_fisica) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pessoa_juridica(
    id_pessoa_juridica INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(150) NOT NULL,
    nome_fantasia VARCHAR(150) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    ie VARCHAR(12)
);

CREATE TABLE IF NOT EXISTS pessoa_juridica_cliente(
    id_cliente INT NOT NULL,
    id_pessoa_juridica INT NOT NULL,
    CONSTRAINT fk_pessoa_juridica_cliente_cliente_id FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    CONSTRAINT fk_pessoa_juridica_cliente_pessoa_fisica_id FOREIGN KEY (id_pessoa_juridica) REFERENCES pessoa_juridica(id_pessoa_juridica) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS funcionario(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    codigo_funcionario CHAR(8) NOT NULL,
    cargo VARCHAR(150) NOT NULL,
    data_admissao DATE NOT NULL,
    data_demissao DATE,
    id_pessoa_fisica INT NOT NULL,
    id_contato INT NOT NULL,
    id_endereco INT NOT NULL,
    CONSTRAINT fk_funcionario_pessoa_fisica FOREIGN KEY (id_pessoa_fisica) REFERENCES pessoa_fisica(id_pessoa_fisica) ON DELETE CASCADE,
    CONSTRAINT fk_funcionario_contato FOREIGN KEY (id_contato) REFERENCES contato(id_contato) ON DELETE CASCADE,
    CONSTRAINT fk_funcionario_endereco FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS especialidade(
    id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
    especialidade ENUM("ELETRICA", "FUNILARIA", "PINTURA", "MECANICA")
);

CREATE TABLE IF NOT EXISTS funcionario_especialidade(
    id_funcionario INT NOT NULL,
    id_especialidade INT NOT NULL,
    CONSTRAINT fk_funcionario_especialidade_funcionario_id FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario) ON DELETE CASCADE,
    CONSTRAINT fk_funcionario_especialidade_especialidade_id FOREIGN KEY (id_especialidade) REFERENCES especialidade(id_especialidade) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS veiculo(
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(60) NOT NULL,
    fabricante VARCHAR(35) NOT NULL,
    cor VARCHAR(25) NOT NULL,
    ano_modelo YEAR NOT NULL,
    ano_fabricacao YEAR NOT NULL,
    placa CHAR(7) NOT NULL,
    chassi CHAR(17),
    id_cliente INT NOT NULL,
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE IF NOT EXISTS ordem_servico(
    id_ordem_servico INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM("ORCAMENTO", "OFICINA", "FINALIZADO", "ENTREGUE") DEFAULT "ORCAMENTO",
    data_emissao DATETIME DEFAULT NOW(),
    data_previsao_conclusao DATETIME,
    data_conclusao DATETIME,
    comentario TEXT,
    orcamento_aprovado TINYINT DEFAULT 0,
    forma_pagamento ENUM("DINHEIRO", "CREDITO", "DEBITO", "PIX") NOT NULL,
    id_veiculo INT NOT NULL,
    CONSTRAINT fk_ordem_servico_veiculo FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

CREATE TABLE IF NOT EXISTS peca(
    id_peca INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(80) NOT NULL,
    valor FLOAT NOT NULL,
    estoque INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS ordem_servico_peca(
    id_ordem_servico INT NOT NULL,
    id_peca INT NOT NULL,
    valor FLOAT NOT NULL,
    quantidade INT DEFAULT 1,
    CONSTRAINT fk_ordem_servico_peca_ordem_servico_id FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico(id_ordem_servico),
    CONSTRAINT fk_ordem_servico_peca_peca_id FOREIGN KEY (id_peca) REFERENCES peca(id_peca)
);

CREATE TABLE IF NOT EXISTS mao_obra(
    id_mao_obra INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(80) NOT NULL,
    valor FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS ordem_servico_mao_obra(
    id_ordem_servico INT NOT NULL,
    id_mao_obra INT NOT NULL,
    valor FLOAT NOT NULL,
    quantidade INT DEFAULT 1,
    CONSTRAINT fk_ordem_servico_mao_obra_ordem_servico_id FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico(id_ordem_servico),
    CONSTRAINT fk_ordem_servico_mao_obra_mao_obra_id FOREIGN KEY (id_mao_obra) REFERENCES mao_obra(id_mao_obra)
);

CREATE TABLE IF NOT EXISTS fornecedor(
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    id_pessoa_juridica INT NOT NULL,
    id_contato INT NOT NULL,
    id_endereco INT NOT NULL,
    CONSTRAINT fk_fornecedor_pessoa_juridica FOREIGN KEY (id_pessoa_juridica) REFERENCES pessoa_juridica(id_pessoa_juridica) ON DELETE CASCADE,
    CONSTRAINT fk_fornecedor_contato FOREIGN KEY (id_contato) REFERENCES contato(id_contato) ON DELETE CASCADE,
    CONSTRAINT fk_fornecedor_endereco FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS peca_fornecedor(
    id_peca INT NOT NULL,
    id_fornecedor INT NOT NULL,
    CONSTRAINT fk_peca_fornecedor_peca_id FOREIGN KEY (id_peca) REFERENCES peca(id_peca),
    CONSTRAINT fk_peca_fornecedor_fornecedor_id FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

CREATE TABLE IF NOT EXISTS funcionario_ordem_servico(
    id_funcionario INT NOT NULL,
    id_ordem_servico INT NOT NULL,
    CONSTRAINT fk_funcionario_ordem_servico_funcionario_id FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    CONSTRAINT fk_funcionario_ordem_servico_ordem_servico_id FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico(id_ordem_servico)
);