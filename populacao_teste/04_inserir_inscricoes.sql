-- =====================================================
-- Script de Inserção de Inscrições
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: inscricoes
-- =====================================================

USE dbtechcourses;

-- Inserção de 15 inscrições conforme requisitos do projeto
-- IMPORTANTE: Este script depende dos scripts 01, 02 e 03 terem sido executados primeiro
-- Distribuição: 10 inscrições concluídas e 5 em andamento
-- Os alunos são distribuídos entre os 5 cursos de forma balanceada
-- Os IDs dos cursos são gerados automaticamente na ordem de inserção:
-- 1 = Introdução a LLMs
-- 2 = Criação de Prompts
-- 3 = NoSQL - Fundamentos
-- 4 = React Avançado
-- 5 = AWS Essentials

INSERT INTO inscricoes (aluno_id, curso_id, status, data_inscricao) VALUES
-- Cursos concluídos
(1, 1, 'concluido', '2024-01-15'),
(2, 1, 'concluido', '2024-01-20'),
(3, 2, 'concluido', '2024-02-10'),
(4, 2, 'concluido', '2024-02-15'),
(5, 3, 'concluido', '2024-03-01'),
(6, 3, 'concluido', '2024-03-05'),
(7, 4, 'concluido', '2024-03-20'),
(8, 4, 'concluido', '2024-03-25'),
(9, 5, 'concluido', '2024-04-10'),
(10, 5, 'concluido', '2024-04-15'),

-- Cursos em andamento
(1, 2, 'em_andamento', '2024-05-01'),
(2, 3, 'em_andamento', '2024-05-05'),
(3, 4, 'em_andamento', '2024-05-10'),
(4, 5, 'em_andamento', '2024-05-15'),
(5, 1, 'em_andamento', '2024-05-20');

-- Verifica a inserção
SELECT 'Inscrições inseridas com sucesso!' AS Status;
SELECT 
    i.id,
    CONCAT(a.nome, ' ', a.sobrenome) AS aluno,
    c.nome AS curso,
    i.status,
    i.data_inscricao
FROM inscricoes i
INNER JOIN alunos a ON i.aluno_id = a.id
INNER JOIN cursos c ON i.curso_id = c.id
ORDER BY i.id;

-- Estatísticas por status
SELECT 
    status,
    COUNT(*) AS quantidade
FROM inscricoes
GROUP BY status;

