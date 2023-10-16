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

SELECT
    produto,
    IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS status_estoque
FROM produtos;

SELECT
    produto,
    CASE
        WHEN preco < 10 THEN 'Barato'
        WHEN preco >= 10 AND preco <= 20 THEN 'Médio'
        ELSE 'Caro'
    END AS categoria_preco
FROM produtos;

DELIMITER //
CREATE FUNCTION TOTAL_VALOR(preco DECIMAL(10, 2), quantidade INT)
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total DECIMAL(10, 2);
    SET total = preco * quantidade;
    RETURN total;
END;
//
DELIMITER ;

SELECT produto, quantidade, preco, TOTAL_VALOR(preco, quantidade) AS valor_total
FROM produtos;

SELECT COUNT(*) AS total_produtos FROM produtos;

SELECT MAX(preco) AS produto_mais_caro FROM produtos;

SELECT MIN(preco) AS produto_mais_barato FROM produtos;

SELECT
    SUM(IF(quantidade > 0, preco, 0)) AS soma_produtos_em_estoque
FROM produtos;



DELIMITER //
CREATE FUNCTION Fatorial(n INT)
RETURNS INT
BEGIN
    DECLARE result INT;
    SET result = 1;
    WHILE n > 0 DO
        SET result = result * n;
        SET n = n - 1;
    END WHILE;
    RETURN result;
END;
//
DELIMITER ;
DELIMITER //
CREATE FUNCTION Exponencial(base DECIMAL(10, 2), expoente INT)
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE result DECIMAL(10, 2);
    SET result = 1;
    IF expoente >= 0 THEN
        WHILE expoente > 0 DO
            SET result = result * base;
            SET expoente = expoente - 1;
        END WHILE;
    ELSE
        RETURN NULL;
    END IF;
    RETURN result;
END;
//
DELIMITER ;
DELIMITER //
CREATE FUNCTION Palindromo(palavra VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE palavra_reversa VARCHAR(255);
    SET palavra_reversa = REVERSE(palavra);
    IF palavra = palavra_reversa THEN
        RETURN 1; 
    ELSE
        RETURN 0; 
    END IF;
END;
//
DELIMITER ;
