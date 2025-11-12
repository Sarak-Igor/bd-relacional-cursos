-- =====================================================
-- Consulta A: Cursos Concluídos vs Em Andamento
-- Projeto: Banco de Dados Cursos Profissionalizantes
-- Objetivo: Contar quantos cursos foram concluídos e quantos estão em andamento
-- Apresentar os dois valores conjuntamente
-- =====================================================

USE dbtechcourses;

-- Consulta principal: apresenta os dois valores (concluídos e em andamento) em uma única linha
-- Usa CASE WHEN para contar cada status separadamente
SELECT 
    SUM(CASE WHEN status = 'concluido' THEN 1 ELSE 0 END) AS cursos_concluidos,
    SUM(CASE WHEN status = 'em_andamento' THEN 1 ELSE 0 END) AS cursos_em_andamento,
    COUNT(*) AS total_inscricoes
FROM inscricoes;

-- Consulta alternativa: apresenta os resultados agrupados por status
-- Útil para visualizar a distribuição de forma mais detalhada
SELECT 
    status,
    COUNT(*) AS quantidade
FROM inscricoes
GROUP BY status;

