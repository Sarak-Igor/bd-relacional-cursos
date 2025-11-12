-- =====================================================
-- Script de Criação da Tabela de Cursos
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: cursos
-- =====================================================

USE dbtechcourses;

-- Remove a tabela se já existir
DROP TABLE IF EXISTS cursos;

-- Cria a tabela de cursos
CREATE TABLE cursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    descricao TEXT,
    categoria_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Relaciona cada curso à sua categoria, garantindo que todo curso tenha uma categoria válida
    -- RESTRICT impede deletar categoria que tenha cursos associados
    -- CASCADE atualiza automaticamente se o ID da categoria mudar
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    -- Índices criados para acelerar consultas frequentes por categoria e busca por nome do curso
    INDEX idx_categoria_id (categoria_id),
    INDEX idx_nome (nome)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Comentários na tabela
ALTER TABLE cursos COMMENT = 'Tabela que armazena os cursos profissionalizantes oferecidos';

-- Comentários nas colunas
ALTER TABLE cursos 
    MODIFY COLUMN id INT AUTO_INCREMENT COMMENT 'Identificador único do curso',
    MODIFY COLUMN nome VARCHAR(200) NOT NULL COMMENT 'Nome do curso',
    MODIFY COLUMN descricao TEXT COMMENT 'Descrição detalhada do curso',
    MODIFY COLUMN categoria_id INT NOT NULL COMMENT 'Referência à categoria do curso';

SELECT 'Tabela cursos criada com sucesso!' AS Status;

