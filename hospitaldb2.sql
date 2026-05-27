
CREATE DATABASE IF NOT EXISTS HospitalDB; -- Adicionada cláusula IF NOT EXISTS para evitar erros se o banco já existir
USE HospitalDB; -- Seleciona o banco de dados para uso

CREATE TABLE Hospitais ( -- CRIAÇÃO DA TABELA HOSPITAIS

   id_hospital INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   cidade VARCHAR(100),
   estado CHAR(2),
   endereco VARCHAR(200)
);

CREATE TABLE Especialidades ( -- CRIAÇÃO DA TABELA ESPECIALIDADES
   id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Medicos ( -- CRIAÇÃO DA TABELA MÉDICOS
   id_medico INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   crm VARCHAR(20) UNIQUE NOT NULL,
   telefone VARCHAR(20),
   email VARCHAR(100),
   salario DECIMAL(10,2),

   id_especialidade INT NOT NULL,
   id_hospital INT NOT NULL,

   FOREIGN KEY (id_especialidade)
       REFERENCES Especialidades(id_especialidade),

   FOREIGN KEY (id_hospital)
       REFERENCES Hospitais(id_hospital)
);

CREATE TABLE Pacientes ( -- CRIAÇÃO DA TABELA PACIENTES
   id_paciente INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   cpf CHAR(11) UNIQUE,
   data_nascimento DATE,
   telefone VARCHAR(20),
   email VARCHAR(100),
   endereco VARCHAR(200),
   tipo_sanguineo VARCHAR(5),
   alergias TEXT
);

CREATE TABLE Convenios ( -- CRIAÇÃO DA TABELA CONVÊNIOS
   id_convenio INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   telefone VARCHAR(20),
   cobertura TEXT
);

CREATE TABLE PacienteConvenio ( -- CRIAÇÃO DA TABELA PACIENTE_CONVENIO
   id_paciente_convenio INT PRIMARY KEY AUTO_INCREMENT,

   id_paciente INT NOT NULL,
   id_convenio INT NOT NULL,

   numero_carteira VARCHAR(50),

   FOREIGN KEY (id_paciente)
       REFERENCES Pacientes(id_paciente),

   FOREIGN KEY (id_convenio)
       REFERENCES Convenios(id_convenio)
);

CREATE TABLE Consultas ( -- CRIAÇÃO DA TABELA CONSULTAS
   id_consulta INT PRIMARY KEY AUTO_INCREMENT,

   data_consulta DATETIME NOT NULL,
   diagnostico TEXT,
   observacoes TEXT,
   valor DECIMAL(10,2),

   id_paciente INT NOT NULL,
   id_medico INT NOT NULL,

   FOREIGN KEY (id_paciente)
       REFERENCES Pacientes(id_paciente),

   FOREIGN KEY (id_medico)
       REFERENCES Medicos(id_medico)
);

CREATE TABLE Medicamentos ( -- CRIAÇÃO DA TABELA MEDICAMENTOS
   id_medicamento INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   fabricante VARCHAR(100),
   estoque INT,
   preco DECIMAL(10,2)
);

CREATE TABLE Receitas ( -- CRIAÇÃO DA TABELA RECEITAS
   id_receita INT PRIMARY KEY AUTO_INCREMENT,

   id_consulta INT NOT NULL,

   data_receita DATE,
   observacoes TEXT,

   FOREIGN KEY (id_consulta)
       REFERENCES Consultas(id_consulta)
);

CREATE TABLE ReceitaMedicamento ( -- CRIAÇÃO DA TABELA RECEITA_MEDICAMENTO
   id_receita_medicamento INT PRIMARY KEY AUTO_INCREMENT,

   id_receita INT NOT NULL,
   id_medicamento INT NOT NULL,

   dosagem VARCHAR(100),
   frequencia VARCHAR(100),

   FOREIGN KEY (id_receita)
       REFERENCES Receitas(id_receita),

   FOREIGN KEY (id_medicamento)
       REFERENCES Medicamentos(id_medicamento)
);

CREATE TABLE Exames ( -- CRIAÇÃO DA TABELA EXAMES
   id_exame INT PRIMARY KEY AUTO_INCREMENT,

   nome VARCHAR(100),
   resultado TEXT,
   data_exame DATE,

   id_paciente INT NOT NULL,
   id_medico INT NOT NULL,

   FOREIGN KEY (id_paciente)
       REFERENCES Pacientes(id_paciente),

   FOREIGN KEY (id_medico)
       REFERENCES Medicos(id_medico)
);

CREATE TABLE Quartos ( -- CRIAÇÃO DA TABELA QUARTOS
   id_quarto INT PRIMARY KEY AUTO_INCREMENT,

   numero VARCHAR(10),
   tipo VARCHAR(50),
   capacidade INT,
   status_quarto VARCHAR(50),

   id_hospital INT NOT NULL,

   FOREIGN KEY (id_hospital)
       REFERENCES Hospitais(id_hospital)
);

CREATE TABLE Internacoes ( -- CRIAÇÃO DA TABELA INTERNAÇÕES
   id_internacao INT PRIMARY KEY AUTO_INCREMENT,

   data_entrada DATETIME,
   data_saida DATETIME,
   motivo TEXT,

   id_paciente INT NOT NULL,
   id_quarto INT NOT NULL,

   FOREIGN KEY (id_paciente)
       REFERENCES Pacientes(id_paciente),

   FOREIGN KEY (id_quarto)
       REFERENCES Quartos(id_quarto)
);

CREATE TABLE Setores (  -- CRIAÇÃO DA TABELA SETORES
   id_setor INT PRIMARY KEY AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL
);

CREATE TABLE Funcionarios ( -- CRIAÇÃO DA TABELA FUNCIONÁRIOS
   id_funcionario INT PRIMARY KEY AUTO_INCREMENT,

   nome VARCHAR(100),
   cpf CHAR(11),
   cargo VARCHAR(100),
   salario DECIMAL(10,2),

   id_setor INT NOT NULL,
   id_hospital INT NOT NULL,

   FOREIGN KEY (id_setor)
       REFERENCES Setores(id_setor),

   FOREIGN KEY (id_hospital)
       REFERENCES Hospitais(id_hospital)
);

CREATE TABLE Pagamentos ( -- CRIAÇÃO DA TABELA PAGAMENTOS
   id_pagamento INT PRIMARY KEY AUTO_INCREMENT,

   valor DECIMAL(10,2),
   data_pagamento DATE,
   forma_pagamento VARCHAR(50),

   id_consulta INT,

   FOREIGN KEY (id_consulta)
       REFERENCES Consultas(id_consulta)
);

CREATE TABLE UsuariosSistema (  -- CRIAÇÃO DA TABELA USUÁRIOS DO SISTEMA
   id_usuario INT PRIMARY KEY AUTO_INCREMENT,

   usuario VARCHAR(50) UNIQUE,
   senha_hash VARCHAR(255),
   nivel_acesso VARCHAR(50)
);

CREATE TABLE Logs ( -- CRIAÇÃO DA TABELA LOGS
   id_log INT PRIMARY KEY AUTO_INCREMENT,

   acao TEXT,
   data_log DATETIME,

   id_usuario INT,

   FOREIGN KEY (id_usuario)
       REFERENCES UsuariosSistema(id_usuario)
);

SELECT M.nome,
       max(M.salario),
       E.nome,
       M.crm 
FROM Medicos AS M
JOIN Especialidades AS E
ON M.id_especialidade=
   E.id_especialidade
   GROUP BY M.nome, E.nome,M.crm
   ORDER BY max(salario) desc;

select M.nome, M.email, E.nome, COUNT (C.id_consulta), M.salario
from Medicos as M
join Especialidades as E
on M.id_especialidade = E.id_especialidade
join Consultas AS C
on  M.id_medico = C.id_medico
group by M.id_medico;

SELECT M.nome, M.email, M.telefone, E.nome as especialidade, H.nome as Hospital, COUNT(Exames.id_exame) as Exames_solicitados
FROM Medicos as M
JOIN Especialidades AS E ON M.id_especialidade = E.id_especialidade
JOIN Hospitais AS H ON M.id_hospital = H.id_hospital
JOIN Exames ON M.id_medico = Exames.id_medico
GROUP BY M.id_medico;

SELECT M.nome,P.nome,C.data_consulta
FROM Medicos AS M, Pacientes AS P, Consultas AS C
WHERE C.id_medico = M.id_medico
AND C.id_paciente = P.id_paciente;