CREATE FUNCTION total_livros_por_genero(genero_nome VARCHAR(255)) RETURNS INT
BEGIN
    DECLARE total_livros INT;
    SELECT COUNT(*) INTO total_livros FROM Livro WHERE genero = genero_nome;
    RETURN total_livros;
END;

CREATE FUNCTION listar_livros_por_autor(primeiro_nome_autor VARCHAR(255), ultimo_nome_autor VARCHAR(255)) RETURNS TABLE
BEGIN
    DECLARE autor_id INT;
    SELECT id INTO autor_id FROM Autor WHERE primeiro_nome = primeiro_nome_autor AND ultimo_nome = ultimo_nome_autor;
    DECLARE lista_livros CURSOR FOR
    SELECT livro.titulo
    FROM Livro_Autor
    JOIN Livro ON Livro_Autor.livro_id = Livro.id
    WHERE Livro_Autor.autor_id = autor_id;
    
    RETURN lista_livros;
END;

CREATE FUNCTION atualizar_resumos()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    DECLARE resumo_livro TEXT;
    DECLARE cur CURSOR FOR SELECT id, resumo FROM Livro;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO livro_id, resumo_livro;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        UPDATE Livro SET resumo = CONCAT(resumo_livro, ' Este é um excelente livro!') WHERE id = livro_id;
    END LOOP;

    CLOSE cur;
END;

CREATE FUNCTION media_livros_por_editora() RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_livros INT;
    DECLARE total_editoras INT;
    DECLARE media DECIMAL(10, 2);
    SELECT SUM(qtd_livros) INTO total_livros FROM (SELECT editora_id, COUNT(*) AS qtd_livros FROM Livro GROUP BY editora_id) AS editora_livros;

    SELECT COUNT(*) INTO total_editoras FROM Editora;

    IF total_editoras > 0 THEN
        SET media = total_livros / total_editoras;
    ELSE
        SET media = 0;
    END IF;

    RETURN media;
END;

CREATE FUNCTION autores_sem_livros() RETURNS TABLE
BEGIN
    DECLARE lista_autores CURSOR FOR
    SELECT Autor.id, Autor.primeiro_nome, Autor.ultimo_nome
    FROM Autor
    LEFT JOIN Livro_Autor ON Autor.id = Livro_Autor.autor_id
    WHERE Livro_Autor.autor_id IS NULL;

    RETURN lista_autores;
END;
