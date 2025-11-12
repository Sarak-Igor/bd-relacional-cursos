-- =====================================================
-- Consulta B: Alunos por Curso
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Objetivo: Contar quantos alunos existem por curso
-- Independente do status das inscrições
-- =====================================================

USE dbtechcourses;

-- Consulta principal: conta quantos alunos únicos existem por curso
-- Usa LEFT JOIN para incluir todos os cursos, mesmo os sem inscrições
-- COUNT(DISTINCT) garante que cada aluno seja contado apenas uma vez por curso
SELECT 
    c.id AS curso_id,
    c.nome AS curso,
    cat.nome AS categoria,
    COUNT(DISTINCT i.aluno_id) AS total_alunos
FROM cursos c
LEFT JOIN inscricoes i ON c.id = i.curso_id
LEFT JOIN categorias cat ON c.categoria_id = cat.id
GROUP BY c.id, c.nome, cat.nome
ORDER BY total_alunos DESC, c.nome;

-- Consulta alternativa: mostra também a distribuição de alunos por status
-- Útil para entender quantos alunos concluíram vs quantos estão em andamento em cada curso
SELECT 
    c.nome AS curso,
    cat.nome AS categoria,
    COUNT(DISTINCT i.aluno_id) AS total_alunos,
    SUM(CASE WHEN i.status = 'concluido' THEN 1 ELSE 0 END) AS alunos_concluidos,
    SUM(CASE WHEN i.status = 'em_andamento' THEN 1 ELSE 0 END) AS alunos_em_andamento
FROM cursos c
LEFT JOIN inscricoes i ON c.id = i.curso_id
LEFT JOIN categorias cat ON c.categoria_id = cat.id
GROUP BY c.id, c.nome, cat.nome
ORDER BY total_alunos DESC, c.nome;

