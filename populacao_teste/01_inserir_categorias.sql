-- =====================================================
-- Script de Inserção de Categorias
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: categorias
-- =====================================================

USE dbtechcourses;

-- Inserção de categorias de cursos
INSERT INTO categorias (nome) VALUES
('Inteligência Artificial'),
('Banco de Dados'),
('Desenvolvimento Web'),
('Cloud Computing'),
('Segurança da Informação');

-- Verifica a inserção
SELECT 'Categorias inseridas com sucesso!' AS Status;
SELECT * FROM categorias ORDER BY id;

