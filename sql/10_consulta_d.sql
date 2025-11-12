-- =====================================================
-- Consulta D: Top 3 Cursos com Melhor Média de Avaliação
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Objetivo: Mostrar os 3 cursos com melhor média de avaliação
-- =====================================================

USE dbtechcourses;

-- Consulta principal: identifica os 3 cursos com melhor média de avaliação
-- Calcula média, total de avaliações e range de notas (menor e maior)
-- Filtra apenas inscrições concluídas e ordena por média decrescente
SELECT 
    c.id AS curso_id,
    c.nome AS curso,
    cat.nome AS categoria,
    COUNT(av.id) AS total_avaliacoes,
    ROUND(AVG(av.nota), 2) AS media_avaliacao,
    MIN(av.nota) AS menor_nota,
    MAX(av.nota) AS maior_nota
FROM cursos c
INNER JOIN categorias cat ON c.categoria_id = cat.id
INNER JOIN inscricoes i ON c.id = i.curso_id
INNER JOIN avaliacoes av ON i.id = av.inscricao_id
WHERE i.status = 'concluido'
GROUP BY c.id, c.nome, cat.nome
ORDER BY media_avaliacao DESC
LIMIT 3;

-- Consulta alternativa: versão que usa HAVING para garantir que apenas cursos com avaliações sejam considerados
-- Útil para casos onde pode haver cursos sem avaliações no banco
SELECT 
    c.nome AS curso,
    cat.nome AS categoria,
    COUNT(av.id) AS total_avaliacoes,
    ROUND(AVG(av.nota), 2) AS media_avaliacao
FROM cursos c
INNER JOIN categorias cat ON c.categoria_id = cat.id
INNER JOIN inscricoes i ON c.id = i.curso_id
INNER JOIN avaliacoes av ON i.id = av.inscricao_id
WHERE i.status = 'concluido'
GROUP BY c.id, c.nome, cat.nome
HAVING COUNT(av.id) > 0
ORDER BY media_avaliacao DESC
LIMIT 3;

