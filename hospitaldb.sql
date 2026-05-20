CREATE DATABASE hp;
USE hp;

-- 1. CRIAR TABELA ESPECIALIDADES
CREATE TABLE Especialidades (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome_especialidade VARCHAR(100) NOT NULL
);

-- 2. CRIAR TABELA MEDICOS
CREATE TABLE Medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_especialidade INT NOT NULL,
    FOREIGN KEY (id_especialidade)
        REFERENCES Especialidades(id_especialidade)
);

-- 3. CRIAR TABELA PACIENTES
CREATE TABLE Pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL
);

-- 4. CRIAR TABELA CONSULTAS
CREATE TABLE Consultas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data_consulta DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_paciente)
        REFERENCES Pacientes(id_paciente),

    FOREIGN KEY (id_medico)
        REFERENCES Medicos(id_medico)
);

-- POPULAR TABELA ESPECIALIDADES

INSERT INTO Especialidades (nome_especialidade) VALUES
('Cardiologia'),
('Pediatria'),
('Clínica Geral');

-- POPULAR TABELA MEDICOS

INSERT INTO Medicos (nome, id_especialidade) VALUES
('Dr. Silva', 1),
('Dra. Maria', 2),
('Dr. Roberto', 3);

-- POPULAR TABELA PACIENTES

INSERT INTO Pacientes (nome, data_nascimento) VALUES
('Carlos Souza', '1985-05-12'),
('Ana Costa', '1990-08-22'),
('Bruno Lima', '2015-03-10'),
('Mariana Dias', '1978-11-04');

-- POPULAR TABELA CONSULTAS

INSERT INTO Consultas (id_paciente, id_medico, data_consulta, valor) VALUES
(1, 1, '2026-01-10', 150.00),
(1, 1, '2026-02-15', 200.00),
(2, 1, '2026-01-12', 120.00),
(3, 2, '2026-03-01', 350.00),
(2, 1, '2026-03-05', 120.00),
(4, 1, '2026-04-18', 250.00),
(1, 1, '2026-05-20', 180.00),
(3, 3, '2026-05-21', 150.00);


SELECT 
    E.nome_especialidade,
    COUNT(C.id_consulta) AS TotalConsultas,
    AVG(C.valor) AS MediaConsultas,
    SUM(C.valor) AS Faturamento

FROM Consultas AS C
JOIN Medicos AS M
ON C.id_medico = M.id_medico
JOIN Especialidades AS E
ON M.id_especialidade = E.id_especialidade
GROUP BY E.nome_especialidade
HAVING SUM(C.valor) > 1000
ORDER BY Faturamento DESC;