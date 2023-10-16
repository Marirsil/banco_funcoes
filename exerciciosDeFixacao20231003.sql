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
