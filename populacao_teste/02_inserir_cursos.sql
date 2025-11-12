-- =====================================================
-- Script de Inserção de Cursos
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: cursos
-- =====================================================

USE dbtechcourses;

-- Inserção de 5 cursos em diferentes categorias conforme requisitos do projeto
-- IMPORTANTE: Este script depende do script 01_inserir_categorias.sql ter sido executado primeiro
-- Os IDs das categorias são gerados automaticamente na ordem de inserção:
-- 1 = Inteligência Artificial
-- 2 = Banco de Dados
-- 3 = Desenvolvimento Web
-- 4 = Cloud Computing
-- 5 = Segurança da Informação

INSERT INTO cursos (nome, descricao, categoria_id) VALUES
('Introdução a LLMs', 'Curso introdutório sobre Large Language Models, explorando conceitos fundamentais, arquiteturas e aplicações práticas.', 1),
('Criação de Prompts', 'Aprenda técnicas avançadas para criação de prompts eficientes em sistemas de IA generativa.', 1),
('NoSQL - Fundamentos', 'Curso completo sobre bancos de dados NoSQL, incluindo MongoDB, Cassandra e Redis.', 2),
('React Avançado', 'Domine React com hooks avançados, context API, performance optimization e testes.', 3),
('AWS Essentials', 'Fundamentos de Amazon Web Services: EC2, S3, RDS e serviços essenciais de cloud computing.', 4);

-- Verifica a inserção
SELECT 'Cursos inseridos com sucesso!' AS Status;
SELECT 
    c.id,
    c.nome AS curso,
    cat.nome AS categoria
FROM cursos c
INNER JOIN categorias cat ON c.categoria_id = cat.id
ORDER BY c.id;

