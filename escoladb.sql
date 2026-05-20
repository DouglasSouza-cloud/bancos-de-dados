
CREATE DATABASE EscolaDB;
USE EscolaDB;

CREATE TABLE Alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    idade INT
);

CREATE TABLE Cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100),
    carga_horaria INT
);

CREATE TABLE Matriculas (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT,
    id_curso INT,
    nota DECIMAL(4,2),
    faltas INT,
    FOREIGN KEY (id_aluno) REFERENCES Alunos(id_aluno),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

INSERT INTO Alunos (nome, cidade, idade) VALUES
('Carlos', 'São Paulo', 18),
('Mariana', 'Curitiba', 22),
('João', 'Florianópolis', 19),
('Fernanda', 'São Paulo', 25),
('Lucas', 'Rio de Janeiro', 20),
('Patricia', 'Curitiba', 21),
('Ana', 'Porto Alegre', 23),
('Bruno', 'São Paulo', 24);

INSERT INTO Cursos (nome_curso, carga_horaria) VALUES
('Python', 40),
('Banco de Dados', 60),
('Java', 80),
('Data Science', 100);

INSERT INTO Matriculas (id_aluno, id_curso, nota, faltas) VALUES
(1, 1, 8.5, 2),
(1, 2, 7.0, 5),
(2, 1, 9.5, 1),
(2, 4, 8.0, 4),
(3, 2, 6.5, 6),
(3, 3, 7.5, 3),
(4, 4, 9.0, 0),
(5, 1, 5.5, 10),
(5, 2, 6.0, 7),
(6, 3, 8.5, 2),
(7, 4, 7.0, 5),
(8, 2, 9.5, 1);

----------------
-- Atividades --
----------------

SELECT * FROM alunos; -- lista todos os alunos cadastrados

SELECT nome FROM alunos; -- lista o nome dos alunos

SELECT * FROM cursos; -- lista todos os os cursos

SELECT * FROM alunos -- lista todos os alunos que moram em são paulo
WHERE cidade = 'São Paulo';

SELECT * FROM alunos -- lista alunos com idade maior que 20
WHERE idade > 20;

SELECT * FROM cursos -- lista cursos com carga horária maior que 50
WHERE carga_horaria > 50;

SELECT nome, idade FROM alunos -- lista alunos com idade de 18 entre 22
WHERE idade BETWEEN 18 AND 22;

SELECT nome, cidade FROM alunos -- lista todos os alunos que moram em curitiba
WHERE cidade = 'Curitiba';

SELECT nome, idade FROM alunos -- lista alunos com idade menor que 21
WHERE idade < 21;

SELECT id_matricula FROM matriculas; -- lista todas as matrículas cadastradas

-------------------------------
-- Atividades intermediárias --
-------------------------------

SELECT a.nome, m.nota -- lista alunos que tiveram nota acima de 8
FROM matriculas AS m
JOIN alunos AS a ON a.id_aluno = m.id_aluno
WHERE nota > 8;

SELECT c.nome_curso, c.carga_horaria -- lista cursos com carga horária igual a 80
FROM cursos AS c
WHERE c.carga_horaria = 80;

SELECT a.nome, m.faltas -- lista alunos que tiveram faltas acima de 5
FROM matriculas AS m
JOIN alunos AS a ON a.id_aluno = m.id_aluno
WHERE faltas > 5;

SELECT nome, cidade 
FROM alunos -- lista todos os alunos que não moram em são paulo
WHERE NOT cidade = 'São Paulo';

SELECT nome -- lista alunos que começam com a letra "a"
FROM alunos 
WHERE nome LIKE 'A%';

SELECT nome -- lista alunos que terminam com a letra "a"
FROM alunos 
WHERE nome LIKE '%A';

SELECT nome_curso -- lista cursos cujo nome tenha "dados"
FROM cursos
WHERE nome_curso LIKE '%dados%';

SELECT id_matricula 
FROM matriculas -- lista matrículas com nota entre 7 e 9
WHERE nota BETWEEN 7 AND 9;

SELECT nome, idade 
FROM alunos -- lista alunos que possuem exatamente 20 anos
WHERE idade = 20;

SELECT nome_curso, carga_horaria -- lista cursos com carga horária menor ou igual 60
FROM cursos 
WHERE carga_horaria <= 60;

-----------------------------
-- Atividades com GROUP BY --
-----------------------------

SELECT cidade, COUNT(*) AS quantidade_alunos -- lista quantidade de alunos em cada cidade
FROM alunos
GROUP BY cidade;

SELECT cidade, AVG(idade) AS media_idade -- lista média de idade de alunos por cidade
FROM alunos
GROUP BY cidade;

SELECT c.nome_curso, COUNT(m.id_matricula) AS quantidade_matriculas -- quantidade de matrículas por cursos
FROM matriculas AS m
JOIN cursos AS c
ON m.id_curso = c.id_curso
GROUP BY c.nome_curso;

SELECT c.nome_curso, AVG(m.nota) AS media_notas -- lista média das notas por cursos
FROM matriculas AS m
JOIN cursos AS c
ON m.id_curso = c.id_curso
GROUP BY c.nome_curso;

SELECT c.nome_curso, SUM(m.faltas) AS total_faltas -- lista total de faltas por cursos
FROM matriculas AS m
JOIN cursos AS c
ON m.id_curso = c.id_curso
GROUP BY c.nome_curso;

SELECT c.nome_curso, MAX(m.nota) AS maior_nota -- lista a maior nota de cada curso
FROM matriculas AS m
JOIN cursos AS c
ON m.id_curso = c.id_curso
GROUP BY c.nome_curso;