-- =====================================================
-- Script de Criação da Tabela de Categorias
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: categorias
-- =====================================================

USE dbtechcourses;

-- Remove a tabela se já existir
DROP TABLE IF EXISTS categorias;

-- Cria a tabela de categorias
CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índice criado para acelerar consultas que buscam categorias pelo nome
    INDEX idx_nome (nome)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Comentários na tabela
ALTER TABLE categorias COMMENT = 'Tabela que armazena as categorias dos cursos profissionalizantes';

-- Comentários nas colunas
ALTER TABLE categorias 
    MODIFY COLUMN id INT AUTO_INCREMENT COMMENT 'Identificador único da categoria',
    MODIFY COLUMN nome VARCHAR(100) NOT NULL UNIQUE COMMENT 'Nome da categoria (ex: IA, Banco de Dados)';

SELECT 'Tabela categorias criada com sucesso!' AS Status;

