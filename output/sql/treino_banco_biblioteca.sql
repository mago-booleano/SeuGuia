-- =========================================
-- 1. CRIANDO O BANCO DE DADOS
-- =========================================
CREATE DATABASE biblioteca;
USE biblioteca;
-- =========================================
-- 2. CRIANDO A TABELA BIBLIOTECARIO
-- =========================================
CREATE TABLE bibliotecario (
    matricula INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL
);
-- =========================================
-- 3. CRIANDO A TABELA LIVRO
-- =========================================
CREATE TABLE livro (
    codigo INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    ano_publicacao INT NOT NULL,
    matricula_bibliotecario INT NOT NULL,
    FOREIGN KEY (matricula_bibliotecario)
        REFERENCES bibliotecario(matricula)
);
-- =========================================
-- 4. CRIANDO A TABELA LEITOR
-- =========================================
CREATE TABLE leitor (
    matricula INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(100) NOT NULL
);
-- =========================================
-- 5. CRIANDO A TABELA INTERMEDIARIA
-- RELACIONAMENTO N:N ENTRE LEITOR E LIVRO
-- =========================================
CREATE TABLE leitor_empresta_livro (
    matricula_leitor INT NOT NULL,
    codigo_livro INT NOT NULL,
    PRIMARY KEY (matricula_leitor, codigo_livro),
    FOREIGN KEY (matricula_leitor)
        REFERENCES leitor(matricula),
    FOREIGN KEY (codigo_livro)
        REFERENCES livro(codigo)
);
-- =========================================
-- 6. INSERINDO BIBLIOTECARIOS (DML)
-- =========================================
INSERT INTO bibliotecario (matricula, nome, cargo)
VALUES
    (201, 'Marina Nunes', 'Bibliotecaria-chefe'),
    (202, 'Rafael Costa', 'Atendente'),
    (203, 'Helena Martins', 'Catalogadora');
-- =========================================
-- 7. INSERINDO LIVROS (DML)
-- =========================================
INSERT INTO livro
(codigo, titulo, ano_publicacao, matricula_bibliotecario)
VALUES
    (1, 'Dom Casmurro', 1899, 201),
    (2, 'O Cortico', 1890, 201),
    (3, 'A Hora da Estrela', 1977, 202),
    (4, 'Capitaes da Areia', 1937, 202),
    (5, 'O Pequeno Principe', 1943, 203);
-- =========================================
-- 8. INSERINDO LEITORES (DML)
-- =========================================
INSERT INTO leitor (matricula, nome, categoria)
VALUES
    (1001, 'Ana Ribeiro', 'Estudante'),
    (1002, 'Bruno Almeida', 'Professor'),
    (1003, 'Carla Mendes', 'Estudante'),
    (1004, 'Diego Ferreira', 'Comunidade'),
    (1005, 'Elisa Santos', 'Estudante');
-- =========================================
-- 9. INSERINDO RELACIONAMENTOS N:N
-- LEITOR EMPRESTA LIVRO
-- =========================================
INSERT INTO leitor_empresta_livro
(matricula_leitor, codigo_livro)
VALUES
    (1001, 1),
    (1001, 3),
    (1001, 5),
    (1002, 1),
    (1002, 3),
    (1003, 2),
    (1003, 4),
    (1004, 4),
    (1004, 5),
    (1005, 3),
    (1005, 4);
-- =========================================
-- 10. SELECT SIMPLES
-- =========================================
-- Exibir todos os bibliotecarios
SELECT * FROM bibliotecario;
-- Exibir todos os livros
SELECT * FROM livro;
-- Exibir todos os leitores
SELECT * FROM leitor;
-- Exibir os relacionamentos entre leitores e livros
SELECT * FROM leitor_empresta_livro;
-- =========================================
-- 11. SELECT COM WHERE
-- =========================================
-- Buscar bibliotecario pela matricula
SELECT * FROM bibliotecario
WHERE matricula = 201;
-- Buscar livros publicados em 1943
SELECT * FROM livro
WHERE ano_publicacao = 1943;
-- Buscar leitor pela matricula
SELECT * FROM leitor
WHERE matricula = 1001;
-- =========================================
-- 12. SELECT COM ORDER BY
-- =========================================
-- Listar bibliotecarios em ordem alfabetica
SELECT * FROM bibliotecario
ORDER BY nome ASC;
-- Listar livros em ordem alfabetica
SELECT * FROM livro
ORDER BY titulo ASC;
-- Listar leitores em ordem alfabetica
SELECT * FROM leitor
ORDER BY nome ASC;
-- =========================================
-- 13. SELECT COM LIKE
-- =========================================
-- Buscar bibliotecarios cujo nome comeca com M
SELECT * FROM bibliotecario
WHERE nome LIKE 'M%';
-- Buscar livros que possuem a palavra
-- "Pequeno" no titulo
SELECT * FROM livro
WHERE titulo LIKE '%Pequeno%';
-- Buscar livros cujo titulo termina com a letra a
SELECT * FROM livro
WHERE titulo LIKE '%a';
-- Buscar leitores cujo nome comeca com A
SELECT * FROM leitor
WHERE nome LIKE 'A%';
-- =========================================
-- 14. SELECT COM INNER JOIN
-- BIBLIOTECARIO E LIVRO (1:N)
-- =========================================
SELECT
    bibliotecario.nome AS bibliotecario,
    livro.titulo AS livro,
    livro.ano_publicacao
FROM bibliotecario
INNER JOIN livro
    ON bibliotecario.matricula = livro.matricula_bibliotecario;
-- =========================================
-- 15. INNER JOIN COM WHERE
-- =========================================
-- Consultar os livros sob responsabilidade
-- da bibliotecaria Marina Nunes
SELECT
    bibliotecario.nome AS bibliotecario,
    livro.titulo AS livro,
    livro.ano_publicacao
FROM bibliotecario
INNER JOIN livro
    ON bibliotecario.matricula = livro.matricula_bibliotecario
WHERE bibliotecario.nome = 'Marina Nunes';
-- =========================================
-- 16. INNER JOIN COM ORDER BY
-- =========================================
SELECT
    bibliotecario.nome AS bibliotecario,
    livro.titulo AS livro,
    livro.ano_publicacao
FROM bibliotecario
INNER JOIN livro
    ON bibliotecario.matricula = livro.matricula_bibliotecario
ORDER BY livro.titulo ASC;
-- =========================================
-- 17. INNER JOIN - RELACIONAMENTO N:N
-- LISTAR LEITORES E OS LIVROS QUE EMPRESTAM
-- =========================================
SELECT
    leitor.nome AS leitor,
    livro.titulo AS livro
FROM leitor
INNER JOIN leitor_empresta_livro
    ON leitor.matricula = leitor_empresta_livro.matricula_leitor
INNER JOIN livro
    ON leitor_empresta_livro.codigo_livro = livro.codigo;
-- =========================================
-- 18. INNER JOIN COM WHERE
-- CONSULTAR OS LIVROS DE UM LEITOR
-- =========================================
SELECT
    leitor.nome AS leitor,
    livro.titulo AS livro
FROM leitor
INNER JOIN leitor_empresta_livro
    ON leitor.matricula = leitor_empresta_livro.matricula_leitor
INNER JOIN livro
    ON leitor_empresta_livro.codigo_livro = livro.codigo
WHERE leitor.nome = 'Ana Ribeiro';
-- =========================================
-- 19. INNER JOIN COM WHERE
-- CONSULTAR OS LEITORES DE UM LIVRO
-- =========================================
SELECT
    livro.titulo AS livro,
    leitor.nome AS leitor
FROM livro
INNER JOIN leitor_empresta_livro
    ON livro.codigo = leitor_empresta_livro.codigo_livro
INNER JOIN leitor
    ON leitor_empresta_livro.matricula_leitor = leitor.matricula
WHERE livro.titulo = 'Dom Casmurro';
-- =========================================
-- 20. INNER JOIN COM ORDER BY
-- LISTAR LEITORES E LIVROS EM ORDEM
-- ALFABETICA
-- =========================================
SELECT
    leitor.nome AS leitor,
    livro.titulo AS livro
FROM leitor
INNER JOIN leitor_empresta_livro
    ON leitor.matricula = leitor_empresta_livro.matricula_leitor
INNER JOIN livro
    ON leitor_empresta_livro.codigo_livro = livro.codigo
ORDER BY leitor.nome ASC, livro.titulo ASC;
-- =========================================
-- 21. INNER JOIN COM TODAS AS TABELAS PRINCIPAIS
-- LEITOR, LIVRO E BIBLIOTECARIO
-- =========================================
SELECT
    leitor.nome AS leitor,
    livro.titulo AS livro,
    bibliotecario.nome AS bibliotecario
FROM leitor
INNER JOIN leitor_empresta_livro
    ON leitor.matricula = leitor_empresta_livro.matricula_leitor
INNER JOIN livro
    ON leitor_empresta_livro.codigo_livro = livro.codigo
INNER JOIN bibliotecario
    ON livro.matricula_bibliotecario = bibliotecario.matricula
ORDER BY leitor.nome ASC;
