-- =====================================================
-- Script de Criação da Tabela de Inscrições
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: inscricoes
-- =====================================================

USE dbtechcourses;

-- Remove a tabela se já existir
DROP TABLE IF EXISTS inscricoes;

-- Cria a tabela de inscrições
CREATE TABLE inscricoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT NOT NULL,
    curso_id INT NOT NULL,
    status ENUM('em_andamento', 'concluido') NOT NULL DEFAULT 'em_andamento',
    data_inscricao DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Relaciona cada inscrição ao aluno e ao curso correspondente
    -- RESTRICT impede deletar aluno ou curso que tenha inscrições associadas
    -- CASCADE atualiza automaticamente se os IDs mudarem
    FOREIGN KEY (aluno_id) REFERENCES alunos(id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    -- Regra de negócio: um aluno não pode ter múltiplas inscrições ativas no mesmo curso
    -- Permitimos múltiplas inscrições se uma estiver concluída e outra em andamento
    -- Mas não permitimos duas inscrições 'em_andamento' para o mesmo aluno/curso
    -- Isso evita duplicação de inscrições ativas e mantém a integridade dos dados
    UNIQUE KEY uk_aluno_curso_ativo (aluno_id, curso_id, status),
    
    -- Índices criados para acelerar consultas frequentes por aluno, curso, status e data de inscrição
    -- Esses índices são essenciais para relatórios e buscas rápidas de inscrições
    INDEX idx_aluno_id (aluno_id),
    INDEX idx_curso_id (curso_id),
    INDEX idx_status (status),
    INDEX idx_data_inscricao (data_inscricao)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Comentários na tabela
ALTER TABLE inscricoes COMMENT = 'Tabela que armazena as inscrições dos alunos nos cursos';

-- Comentários nas colunas
ALTER TABLE inscricoes 
    MODIFY COLUMN id INT AUTO_INCREMENT COMMENT 'Identificador único da inscrição',
    MODIFY COLUMN aluno_id INT NOT NULL COMMENT 'Referência ao aluno',
    MODIFY COLUMN curso_id INT NOT NULL COMMENT 'Referência ao curso',
    MODIFY COLUMN status ENUM('em_andamento', 'concluido') NOT NULL DEFAULT 'em_andamento' COMMENT 'Status da inscrição: em_andamento ou concluido',
    MODIFY COLUMN data_inscricao DATE NOT NULL COMMENT 'Data em que a inscrição foi realizada';

SELECT 'Tabela inscricoes criada com sucesso!' AS Status;

