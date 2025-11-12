-- =====================================================
-- Script de Inserção de Avaliações
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Tabela: avaliacoes
-- =====================================================

USE dbtechcourses;

-- Inserção de 10 avaliações conforme requisitos do projeto
-- IMPORTANTE: Este script depende do script 04_inserir_inscricoes.sql ter sido executado primeiro
-- Regra de negócio: avaliações só podem ser criadas para inscrições com status 'concluido'
-- O trigger trg_avaliacao_inscricao_concluida valida automaticamente esta regra
-- As inscrições concluídas correspondem aos IDs 1 a 10 (primeiras 10 inserções do script anterior)

INSERT INTO avaliacoes (inscricao_id, nota, comentario, data_avaliacao) VALUES
(1, 9.5, 'Excelente curso! Conteúdo muito bem explicado e prático.', '2024-02-20'),
(2, 8.0, 'Bom curso, mas poderia ter mais exemplos práticos.', '2024-02-25'),
(3, 9.0, 'Muito útil para entender prompts avançados. Recomendo!', '2024-03-15'),
(4, 7.5, 'Curso interessante, mas alguns conceitos poderiam ser mais detalhados.', '2024-03-20'),
(5, 10.0, 'Perfeito! Aprendi muito sobre NoSQL. Professor excelente.', '2024-04-05'),
(6, 8.5, 'Bom conteúdo sobre bancos NoSQL. Material didático completo.', '2024-04-10'),
(7, 9.0, 'React Avançado realmente avançado! Muito conhecimento prático.', '2024-04-25'),
(8, 8.0, 'Curso bom, mas esperava mais sobre testes automatizados.', '2024-04-30'),
(9, 9.5, 'AWS Essentials muito completo. Ótima introdução à cloud.', '2024-05-15'),
(10, 7.0, 'Conteúdo básico, mas bem estruturado. Bom para iniciantes.', '2024-05-20');

-- Verifica a inserção
SELECT 'Avaliações inseridas com sucesso!' AS Status;
SELECT 
    av.id,
    CONCAT(a.nome, ' ', a.sobrenome) AS aluno,
    c.nome AS curso,
    av.nota,
    av.comentario,
    av.data_avaliacao
FROM avaliacoes av
INNER JOIN inscricoes i ON av.inscricao_id = i.id
INNER JOIN alunos a ON i.aluno_id = a.id
INNER JOIN cursos c ON i.curso_id = c.id
ORDER BY av.id;

-- Estatísticas de avaliações
SELECT 
    COUNT(*) AS total_avaliacoes,
    AVG(nota) AS media_geral,
    MIN(nota) AS menor_nota,
    MAX(nota) AS maior_nota
FROM avaliacoes;

