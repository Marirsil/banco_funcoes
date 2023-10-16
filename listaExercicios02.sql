CREATE DATABASE listaFuncoes;
USE listaFuncoes;

CREATE TABLE nomes (
    nome VARCHAR(50)
);

INSERT INTO nomes (nome) VALUES
    ('Roberta'),
    ('Roberto'),
    ('Maria Clara'),
    ('João');

SELECT UPPER(nome) FROM nomes;

SELECT nome, LENGTH(nome) AS tamanho FROM nomes;

SELECT
    CASE
        WHEN nome LIKE '%Maria%' THEN CONCAT('Sra. ', nome)
        ELSE CONCAT('Sr. ', nome)
    END AS nome_com_tratamento
FROM nomes;

CREATE TABLE produtos (
    produto VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade INT
);

INSERT INTO produtos (produto, preco, quantidade) VALUES
    ('Produto A', 19.99, 5),
    ('Produto B', 25.50, 8),
    ('Produto C', 9.99, 0);

SELECT produto, ROUND(preco, 2) AS preco_arredondado FROM produtos;

SELECT produto, ABS(quantidade) AS quantidade_absoluta FROM produtos;

SELECT AVG(preco) AS media_precos FROM produtos;

CREATE TABLE eventos (
    data_evento DATE
);

INSERT INTO eventos (data_evento) VALUES
    ('2023-10-15'),
    ('2023-10-20'),
    ('2023-11-05');

INSERT INTO eventos (data_evento) VALUES (NOW());

SELECT
    DATEDIFF('2023-11-05', '2023-10-15') AS dias_entre_datas
FROM eventos
WHERE data_evento = '2023-11-05';

SELECT data_evento, DAYNAME(data_evento) AS dia_da_semana FROM eventos;
