-- =====================================================
-- Script de Criação da Tabela de Alunos
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: alunos
-- =====================================================

USE dbtechcourses;

-- Remove a tabela se já existir
DROP TABLE IF EXISTS alunos;

-- Cria a tabela de alunos
CREATE TABLE alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices criados para acelerar consultas frequentes por CPF, email e busca por nome completo
    -- O índice composto nome_sobrenome otimiza buscas que usam ambos os campos juntos
    INDEX idx_cpf (cpf),
    INDEX idx_email (email),
    INDEX idx_nome_sobrenome (nome, sobrenome)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Comentários na tabela
ALTER TABLE alunos COMMENT = 'Tabela que armazena os dados dos alunos';

-- Comentários nas colunas
ALTER TABLE alunos 
    MODIFY COLUMN id INT AUTO_INCREMENT COMMENT 'Identificador único do aluno',
    MODIFY COLUMN nome VARCHAR(100) NOT NULL COMMENT 'Primeiro nome do aluno',
    MODIFY COLUMN sobrenome VARCHAR(100) NOT NULL COMMENT 'Sobrenome do aluno',
    MODIFY COLUMN cpf VARCHAR(11) NOT NULL UNIQUE COMMENT 'CPF do aluno (11 dígitos, único)',
    MODIFY COLUMN email VARCHAR(255) NOT NULL UNIQUE COMMENT 'E-mail do aluno (único)',
    MODIFY COLUMN data_nascimento DATE NOT NULL COMMENT 'Data de nascimento do aluno';

SELECT 'Tabela alunos criada com sucesso!' AS Status;

