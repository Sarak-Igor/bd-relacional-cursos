-- =====================================================
-- Script de Inserção de Alunos
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: alunos
-- =====================================================

USE dbtechcourses;

-- Inserção de 12 alunos fictícios (requisito mínimo: 10 alunos)
-- Cada aluno possui nome, sobrenome, CPF único, email único e data de nascimento
INSERT INTO alunos (nome, sobrenome, cpf, email, data_nascimento) VALUES
('João', 'Silva', '12345678901', 'joao.silva@email.com', '1990-05-15'),
('Maria', 'Santos', '23456789012', 'maria.santos@email.com', '1992-08-22'),
('Pedro', 'Oliveira', '34567890123', 'pedro.oliveira@email.com', '1988-11-30'),
('Ana', 'Costa', '45678901234', 'ana.costa@email.com', '1995-03-10'),
('Carlos', 'Pereira', '56789012345', 'carlos.pereira@email.com', '1991-07-18'),
('Juliana', 'Ferreira', '67890123456', 'juliana.ferreira@email.com', '1993-12-05'),
('Roberto', 'Almeida', '78901234567', 'roberto.almeida@email.com', '1989-04-25'),
('Fernanda', 'Lima', '89012345678', 'fernanda.lima@email.com', '1994-09-14'),
('Ricardo', 'Martins', '90123456789', 'ricardo.martins@email.com', '1992-01-20'),
('Patricia', 'Rocha', '01234567890', 'patricia.rocha@email.com', '1996-06-08'),
('Lucas', 'Carvalho', '11223344556', 'lucas.carvalho@email.com', '1990-10-12'),
('Amanda', 'Barbosa', '22334455667', 'amanda.barbosa@email.com', '1993-02-28');

-- Verifica a inserção
SELECT 'Alunos inseridos com sucesso!' AS Status;
SELECT 
    id,
    nome,
    sobrenome,
    cpf,
    email,
    data_nascimento
FROM alunos
ORDER BY id;

