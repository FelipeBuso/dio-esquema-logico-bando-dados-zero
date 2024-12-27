USE oficina_mecanica;

-- Lista de Clientes 
SELECT
    c.id_cliente,
    c.tipo,
    CASE
        WHEN c.tipo = 'PF' THEN pf.nome_completo
        WHEN c.tipo = 'PJ' THEN pj.razao_social
        ELSE 'Não especificado'
    END AS nome_cliente,
    co.email,
    co.celular,
    co.telefone,
    co.contato,
    e.logradouro,
    e.numero,
    e.complemento,
    e.bairro,
    e.cidade,
    e.uf,
    e.cep
FROM
    cliente c
    LEFT JOIN pessoa_fisica_cliente pfc ON c.id_cliente = pfc.id_cliente
    LEFT JOIN pessoa_fisica pf ON pfc.id_pessoa_fisica = pf.id_pessoa_fisica
    LEFT JOIN pessoa_juridica_cliente pjc ON c.id_cliente = pjc.id_cliente
    LEFT JOIN pessoa_juridica pj ON pjc.id_pessoa_juridica = pj.id_pessoa_juridica
    LEFT JOIN contato co ON c.id_contato = co.id_contato
    LEFT JOIN endereco e ON c.id_endereco = e.id_endereco;

SELECT
    osp.id_ordem_servico,
    ROUND(SUM(valor), 2) AS valor_pecas
FROM
    ordem_servico_peca osp
GROUP BY
    osp.id_ordem_servico;

-- Ordens de serviço com valores calculados e maiores que 0
SELECT
    os.id_ordem_servico,
    CASE
        WHEN c.tipo = 'PF' THEN pf.nome_completo
        WHEN c.tipo = 'PJ' THEN pj.razao_social
        ELSE 'Não especificado'
    END AS nome_cliente,
    v.modelo AS veiculo,
    c.id_cliente,
    valor_pecas,
    valor_mao_obra,
    (valor_pecas + valor_mao_obra) AS total_ordem_servico
from
    ordem_servico os
    LEFT JOIN(
        SELECT
            osp.id_ordem_servico AS id,
            ROUND(SUM(valor), 2) AS valor_pecas
        FROM
            ordem_servico_peca osp
        GROUP BY
            osp.id_ordem_servico
    ) AS pecas ON os.id_ordem_servico = pecas.id
    LEFT JOIN(
        SELECT
            osmo.id_ordem_servico AS id,
            ROUND(SUM(valor), 2) AS valor_mao_obra
        FROM
            ordem_servico_mao_obra osmo
        GROUP BY
            osmo.id_ordem_servico
    ) AS mao_obra ON os.id_ordem_servico = mao_obra.id
    JOIN veiculo v ON os.id_veiculo = v.id_veiculo
    JOIN cliente c ON v.id_cliente = c.id_cliente
    LEFT JOIN pessoa_fisica_cliente pfc ON c.id_cliente = pfc.id_cliente
    LEFT JOIN pessoa_fisica pf ON pfc.id_pessoa_fisica = pf.id_pessoa_fisica
    LEFT JOIN pessoa_juridica_cliente pjc ON c.id_cliente = pjc.id_cliente
    LEFT JOIN pessoa_juridica pj ON pjc.id_pessoa_juridica = pj.id_pessoa_juridica
HAVING
    total_ordem_servico > 0
ORDER BY
    nome_cliente;

-- Equipe de funcionarios por ordem de serviço
SELECT
    f.id_funcionario AS id,
    pf.nome_completo AS nome,
    date_format(f.data_admissao, "%d/%m/%Y") AS admissao,
    e.especialidade
FROM
    funcionario f
    JOIN funcionario_ordem_servico fos ON f.id_funcionario = fos.id_funcionario
    JOIN pessoa_fisica pf ON f.id_pessoa_fisica = pf.id_pessoa_fisica
    JOIN funcionario_especialidade fe ON f.id_funcionario = fe.id_funcionario
    JOIN especialidade e ON e.id_especialidade = fe.id_especialidade
WHERE
    fos.id_ordem_servico = 1
ORDER BY
    pf.nome_completo DESC;

-- Lista de peças com estoque baixo e fornecedor
SELECT
    p.id_peca AS id,
    p.descricao AS peca,
    p.estoque AS quantidade,
    pj.razao_social AS fornecedor
FROM
    peca p
    JOIN peca_fornecedor pf ON p.id_peca = pf.id_peca
    JOIN fornecedor f ON f.id_fornecedor = pf.id_fornecedor
    JOIN pessoa_juridica pj ON f.id_pessoa_juridica = pj.id_pessoa_juridica
HAVING
    estoque < 5;