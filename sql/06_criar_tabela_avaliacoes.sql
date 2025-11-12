-- =====================================================
-- Script de Criação da Tabela de Avaliações
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: avaliacoes
-- =====================================================

USE dbtechcourses;

-- Remove a tabela se já existir
DROP TABLE IF EXISTS avaliacoes;

-- Cria a tabela de avaliações
CREATE TABLE avaliacoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    inscricao_id INT NOT NULL UNIQUE,
    nota DECIMAL(4,2) NOT NULL,
    comentario TEXT,
    data_avaliacao DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Relaciona cada avaliação à sua inscrição correspondente (relacionamento 1:1)
    -- CASCADE garante que se a inscrição for deletada, a avaliação também será removida
    -- Isso mantém a consistência dos dados, pois avaliação sem inscrição não faz sentido
    FOREIGN KEY (inscricao_id) REFERENCES inscricoes(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- Validação de domínio: a nota deve estar sempre entre 0 e 10
    -- Isso garante que apenas valores válidos sejam aceitos no sistema
    CHECK (nota >= 0 AND nota <= 10),
    
    -- Índices criados para acelerar consultas frequentes por inscrição, nota e data de avaliação
    -- Esses índices são importantes para relatórios de desempenho e análises estatísticas
    INDEX idx_inscricao_id (inscricao_id),
    INDEX idx_nota (nota),
    INDEX idx_data_avaliacao (data_avaliacao)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Comentários na tabela
ALTER TABLE avaliacoes COMMENT = 'Tabela que armazena as avaliações dos cursos concluídos pelos alunos';

-- Comentários nas colunas
ALTER TABLE avaliacoes 
    MODIFY COLUMN id INT AUTO_INCREMENT COMMENT 'Identificador único da avaliação',
    MODIFY COLUMN inscricao_id INT NOT NULL UNIQUE COMMENT 'Referência à inscrição (relacionamento 1:1)',
    MODIFY COLUMN nota DECIMAL(4,2) NOT NULL COMMENT 'Nota atribuída ao curso (0 a 10)',
    MODIFY COLUMN comentario TEXT COMMENT 'Comentário sobre o curso',
    MODIFY COLUMN data_avaliacao DATE NOT NULL COMMENT 'Data em que a avaliação foi realizada';

-- Trigger que valida a regra de negócio: avaliação só pode ser criada para inscrição concluída
-- Este trigger garante que alunos só possam avaliar cursos que já concluíram
-- Impede criação de avaliações para cursos ainda em andamento, mantendo a integridade dos dados
DELIMITER $$

CREATE TRIGGER trg_avaliacao_inscricao_concluida
BEFORE INSERT ON avaliacoes
FOR EACH ROW
BEGIN
    DECLARE inscricao_status VARCHAR(20);
    
    SELECT status INTO inscricao_status
    FROM inscricoes
    WHERE id = NEW.inscricao_id;
    
    IF inscricao_status != 'concluido' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Avaliação só pode ser criada para inscrições com status "concluido"';
    END IF;
END$$

DELIMITER ;

SELECT 'Tabela avaliacoes criada com sucesso!' AS Status;
SELECT 'Trigger de validação de status criado com sucesso!' AS Status;

