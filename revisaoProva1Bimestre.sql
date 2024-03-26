create database bd;
use bd;

create table autor(
	idAutor int not null auto_increment,
    nome varchar(50) not null,
    dataNascimento int not null,
    dataFalecimento int null,
    primary key(idAutor)
);

INSERT INTO autor(nome, dataNascimento, dataFalecimento) VALUES
("Pedro", 2000, NULL),
("Gabriel", 1995, NULL),
("Augusto", 1975, 2020),
("Marcos", 1986, NULL),
("Fabio", 1979, 2015);

create table livro(
	idLivro int not null auto_increment,
    autorId int null,
    titulo varchar(50) not null,
    anoPublicacao int not null,
    casaPublicacao varchar(75) not null,
    classificacao float not null,
    primary key(idLivro)
);

INSERT INTO livro(autorId, titulo, anoPublicacao, casaPublicacao, classificacao) VALUES
(1, "teste1", 2000, "casa1", 5.0),
(3, "teste2", 1975, "casa1", 2.5),
(1, "teste5", 2010, "casa3", 3.0),
(2, "teste4", 1999, "casa2", 4.0),
(4, "teste3", 1989, "casa5", 3.0),
(5, "teste7", 1988, "casa4", 3.5);

create table adaptacao(
	livroId int not null,
    tipo varchar(15) not null,
    titulo varchar(50) not null,
    anoLancamento int not null,
    avaliacao float not null,
    primary key(livroId)
);

INSERT INTO adaptacao(livroId, tipo, titulo, anoLancamento, avaliacao) VALUES
(1, "movie", "titulo1", 2000, 3),
(3, "movie", "titulo3", 1999, 5),
(5, "movie", "titulo4", 1995, 2.5),
(2, "movie", "titulo2", 2012, 3.5);

create table review_livro(
	livroId int,
    resumoResenha varchar(100) not null,
    autor varchar(50) not null,
    primary key(livroId)
);

INSERT INTO review_livro(livroId, resumoResenha, autor) VALUES
(1, "resumo1", "ator1"),
(4, "resumo7", "ator3"),
(3, "resumo3", "ator6"),
(2, "resumo2", "ator2");


-- https://learnsql.com.br/blog/juncoes-de-sql-12-perguntas-praticas-com-respostas-detalhadas/
-- JOIN
-- Ex 01
-- Mostre o nome de cada autor junto com o título do livro que ele escreveu e o ano em que o livro foi publicado.

SELECT nome, titulo, anoPublicacao
FROM autor 
JOIN livro ON autor.idAutor = livro.autorId; -- Ou INNER JOIN ou JOIN sao a mesma coisa

-- Ex 02
-- Mostre o nome de cada autor junto com o título do livro que ele escreveu e o ano em que o livro foi publicado. Mostre somente os livros publicados depois de 2005.

SELECT nome, titulo, anoPublicacao
FROM autor
JOIN livro ON autor.idAutor = livro.autorId
WHERE livro.anoPublicacao > 2005;

/* Ex 03
- Para cada livro, mostre seu título, título da adaptação, ano de adaptação e ano de publicação.
- Inclua apenas os livros com uma classificação inferior à classificação de sua adaptação correspondente. Além disso, mostre apenas os livros para os quais uma adaptação foi lançada dentro de quatro anos da publicação do livro.
- Renomeie a coluna title da tabela book para book_title e a coluna title da tabela adaptation tabela para adaptation_title.
*/

SELECT 
livro.titulo AS livro_titulo,
adaptacao.titulo AS adaptacao_titulo,
livro.anoPublicacao,
adaptacao.anoLancamento
FROM livro
JOIN adaptacao ON livro.idLivro = adaptacao.livroId
WHERE adaptacao.anoLancamento - livro.anoPublicacao <= 4
AND livro.classificacao < adaptacao.avaliacao;

-- LEFT JOIN
-- Ex 04
-- Mostre o título de cada livro junto com o título de sua adaptação e a data de lançamento. Mostre todos os livros, independentemente de terem ou não adaptações.

SELECT
livro.titulo,
adaptacao.titulo,
adaptacao.anoLancamento
FROM livro
LEFT JOIN adaptacao ON livro.idLivro = adaptacao.livroId;

-- RIGHT JOIN
/* Ex 6
Unir as tabelas book_review e book usando um RIGHT JOIN. Mostre o título do livro, a resenha correspondente e o nome do autor da resenha. Considere todos os livros, mesmo aqueles que não foram resenhados.
*/

SELECT
livro.titulo,
review_livro.resumoResenha,
review_livro.autor
FROM review_livro
RIGHT JOIN livro ON livro.idLivro = review_livro.livroId;