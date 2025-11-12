# Resultados das Consultas SQL

Este documento apresenta os resultados esperados das consultas SQL obrigatórias do projeto Banco de Dados Cursos Profissionalizantes.

## Dados de Referência

Com base nos scripts de inserção de dados (`populacao_teste/`), temos:

- **5 categorias**: Inteligência Artificial, Banco de Dados, Desenvolvimento Web, Cloud Computing, Segurança da Informação
- **5 cursos**: Introdução a LLMs, Criação de Prompts, NoSQL - Fundamentos, React Avançado, AWS Essentials
- **12 alunos**: João Silva, Maria Santos, Pedro Oliveira, Ana Costa, Carlos Pereira, Juliana Ferreira, Roberto Almeida, Fernanda Lima, Ricardo Martins, Patricia Rocha, Lucas Carvalho, Amanda Barbosa
- **15 inscrições**: 10 concluídas e 5 em andamento
- **10 avaliações**: Todas para cursos concluídos

---

## Consulta A: Cursos Concluídos vs Em Andamento

### Objetivo
Contar quantos cursos foram concluídos e quantos estão em andamento, apresentando os dois valores conjuntamente.

### SQL Executado
```sql
SELECT 
    SUM(CASE WHEN status = 'concluido' THEN 1 ELSE 0 END) AS cursos_concluidos,
    SUM(CASE WHEN status = 'em_andamento' THEN 1 ELSE 0 END) AS cursos_em_andamento,
    COUNT(*) AS total_inscricoes
FROM inscricoes;
```

### Resultado Esperado

| cursos_concluidos | cursos_em_andamento | total_inscricoes |
|-------------------|---------------------|------------------|
| 10                | 5                   | 15               |

### Observações
- O resultado mostra que há 10 inscrições com status 'concluido' e 5 com status 'em_andamento'
- O total de inscrições é 15, conforme especificado nos requisitos

---

## Consulta B: Alunos por Curso

### Objetivo
Contar quantos alunos existem por curso, independente do status das inscrições.

### SQL Executado
```sql
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
```

### Resultado Esperado

| curso_id | curso                    | categoria                  | total_alunos |
|----------|--------------------------|----------------------------|--------------|
| 1        | Introdução a LLMs        | Inteligência Artificial    | 2            |
| 2        | Criação de Prompts       | Inteligência Artificial    | 2            |
| 3        | NoSQL - Fundamentos      | Banco de Dados             | 2            |
| 4        | React Avançado           | Desenvolvimento Web        | 2            |
| 5        | AWS Essentials           | Cloud Computing            | 2            |

### Observações
- Cada curso tem 2 alunos inscritos (distribuição uniforme)
- A contagem é feita usando `COUNT(DISTINCT i.aluno_id)` para evitar duplicatas caso um aluno tenha múltiplas inscrições no mesmo curso
- Todos os cursos têm pelo menos uma inscrição

---

## Consulta C: Alunos que Concluíram Cursos com Avaliações

### Objetivo
Listar alunos que concluíram cursos, seus respectivos cursos e avaliações.

### SQL Executado
```sql
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
```

### Resultado Esperado (Primeiras linhas)

| aluno            | email                      | curso                    | categoria                  | nota | avaliacao_comentario                                    | data_inscricao | data_avaliacao |
|------------------|----------------------------|--------------------------|----------------------------|------|--------------------------------------------------------|----------------|----------------|
| Ana Costa        | ana.costa@email.com        | Criação de Prompts       | Inteligência Artificial    | 7.5  | Curso interessante, mas alguns conceitos poderiam ser... | 2024-02-15     | 2024-03-20     |
| Carlos Pereira   | carlos.pereira@email.com   | NoSQL - Fundamentos      | Banco de Dados             | 10.0 | Perfeito! Aprendi muito sobre NoSQL. Professor...       | 2024-03-01     | 2024-04-05     |
| Fernanda Lima    | fernanda.lima@email.com    | React Avançado           | Desenvolvimento Web        | 8.0  | Curso bom, mas esperava mais sobre testes...           | 2024-03-25     | 2024-04-30     |
| João Silva       | joao.silva@email.com       | Introdução a LLMs        | Inteligência Artificial    | 9.5  | Excelente curso! Conteúdo muito bem explicado...       | 2024-01-15     | 2024-02-20     |
| Juliana Ferreira | juliana.ferreira@email.com | NoSQL - Fundamentos      | Banco de Dados             | 8.5  | Bom conteúdo sobre bancos NoSQL. Material...           | 2024-03-05     | 2024-04-10     |
| ...              | ...                        | ...                      | ...                        | ...  | ...                                                    | ...            | ...            |

### Observações
- Todos os 10 alunos que concluíram cursos têm avaliações registradas
- As notas variam de 7.0 a 10.0
- Cada aluno aparece uma vez por curso concluído
- Os resultados estão ordenados por nome do aluno e nome do curso

---

## Consulta D: Top 3 Cursos com Melhor Média de Avaliação

### Objetivo
Mostrar os 3 cursos com melhor média de avaliação.

### SQL Executado
```sql
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
```

### Resultado Esperado

| curso_id | curso                    | categoria                  | total_avaliacoes | media_avaliacao | menor_nota | maior_nota |
|----------|--------------------------|----------------------------|------------------|-----------------|------------|------------|
| 3        | NoSQL - Fundamentos      | Banco de Dados             | 2                | 9.25            | 8.5        | 10.0       |
| 1        | Introdução a LLMs        | Inteligência Artificial    | 2                | 8.75            | 8.0        | 9.5        |
| 4        | React Avançado           | Desenvolvimento Web        | 2                | 8.50            | 8.0        | 9.0        |

### Cálculo das Médias

1. **NoSQL - Fundamentos**: (10.0 + 8.5) / 2 = **9.25**
2. **Introdução a LLMs**: (9.5 + 8.0) / 2 = **8.75**
3. **React Avançado**: (9.0 + 8.0) / 2 = **8.50**

### Observações
- Cada curso tem 2 avaliações (conforme dados inseridos)
- Os cursos são ordenados pela média de avaliação em ordem decrescente
- Apenas os 3 melhores cursos são exibidos devido ao `LIMIT 3`
- Todos os cursos concluídos têm avaliações registradas

---

## Resumo Estatístico Geral

### Distribuição de Inscrições
- **Total de inscrições**: 15
- **Inscrições concluídas**: 10 (66.67%)
- **Inscrições em andamento**: 5 (33.33%)

### Distribuição de Alunos
- **Total de alunos**: 12
- **Alunos por curso**: 2 (distribuição uniforme)

### Distribuição de Avaliações
- **Total de avaliações**: 10
- **Média geral de avaliações**: 8.70
- **Menor nota**: 7.0
- **Maior nota**: 10.0

### Cursos Mais Bem Avaliados
1. NoSQL - Fundamentos: 9.25
2. Introdução a LLMs: 8.75
3. React Avançado: 8.50

---

## Notas de Execução

Para executar as consultas e obter estes resultados:

1. Execute os scripts de criação na ordem:
   ```bash
   sql/01_criar_banco.sql
   sql/02_criar_tabela_categorias.sql
   sql/03_criar_tabela_cursos.sql
   sql/04_criar_tabela_alunos.sql
   sql/05_criar_tabela_inscricoes.sql
   sql/06_criar_tabela_avaliacoes.sql
   ```

2. Execute os scripts de inserção na ordem:
   ```bash
   populacao_teste/01_inserir_categorias.sql
   populacao_teste/02_inserir_cursos.sql
   populacao_teste/03_inserir_alunos.sql
   populacao_teste/04_inserir_inscricoes.sql
   populacao_teste/05_inserir_avaliacoes.sql
   ```

3. Execute as consultas:
   ```bash
   sql/07_consulta_a.sql
   sql/08_consulta_b.sql
   sql/09_consulta_c.sql
   sql/10_consulta_d.sql
   ```

---

**Data de criação**: 2024
**Projeto**: Banco de Dados Cursos Profissionalizantes - Cognitive Data Science

