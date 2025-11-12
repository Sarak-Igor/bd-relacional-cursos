-- =====================================================
-- Consulta C: Alunos que Concluíram Cursos com Avaliações
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Objetivo: Listar alunos que concluíram cursos, seus respectivos cursos e avaliações
-- =====================================================

USE dbtechcourses;

-- Consulta principal: lista todos os alunos que concluíram cursos com suas respectivas avaliações
-- Usa LEFT JOIN em avaliações para incluir alunos que concluíram mas ainda não avaliaram
-- Filtra apenas inscrições com status 'concluido' conforme requisito
SELECT 
    CONCAT(a.nome, ' ', a.sobrenome) AS aluno,
    a.email,
    c.nome AS curso,
    cat.nome AS categoria,
    av.nota,
    av.comentario AS avaliacao_comentario,
    i.data_inscricao,
    av.data_avaliacao
FROM inscricoes i
INNER JOIN alunos a ON i.aluno_id = a.id
INNER JOIN cursos c ON i.curso_id = c.id
INNER JOIN categorias cat ON c.categoria_id = cat.id
LEFT JOIN avaliacoes av ON i.id = av.inscricao_id
WHERE i.status = 'concluido'
ORDER BY a.nome, a.sobrenome, c.nome;

-- Consulta alternativa: versão simplificada com indicação de status de avaliação
-- Mostra claramente quais cursos foram avaliados e quais ainda não foram
SELECT 
    CONCAT(a.nome, ' ', a.sobrenome) AS aluno,
    c.nome AS curso,
    av.nota,
    av.comentario AS avaliacao_comentario,
    CASE 
        WHEN av.id IS NOT NULL THEN 'Avaliado'
        ELSE 'Não avaliado'
    END AS status_avaliacao
FROM inscricoes i
INNER JOIN alunos a ON i.aluno_id = a.id
INNER JOIN cursos c ON i.curso_id = c.id
LEFT JOIN avaliacoes av ON i.id = av.inscricao_id
WHERE i.status = 'concluido'
ORDER BY a.nome, a.sobrenome, c.nome;

