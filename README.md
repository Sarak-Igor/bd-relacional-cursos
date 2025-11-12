# Banco de Dados Cursos Profissionalizantes

Projeto de banco de dados relacional para gerenciar cursos profissionalizantes, alunos, inscrições e avaliações. Desenvolvido como parte da disciplina de Cognitive Data Science - Futuro do Trabalho.

## Estrutura do Projeto

```
.
├── docs/
│   ├── diagrama_der.md                # Diagrama visual DER em formato Mermaid
│   ├── modelo_conceitual_logico.md    # Documentação do modelo conceitual e lógico
│   └── resultados_consultas.md        # Resultados esperados das consultas SQL
├── sql/
│   ├── 01_criar_banco.sql            # Criação do banco de dados
│   ├── 02_criar_tabela_categorias.sql
│   ├── 03_criar_tabela_cursos.sql
│   ├── 04_criar_tabela_alunos.sql
│   ├── 05_criar_tabela_inscricoes.sql
│   ├── 06_criar_tabela_avaliacoes.sql
│   ├── 07_consulta_a.sql             # Consulta: Cursos concluídos vs em andamento
│   ├── 08_consulta_b.sql             # Consulta: Alunos por curso
│   ├── 09_consulta_c.sql             # Consulta: Alunos que concluíram com avaliações
│   └── 10_consulta_d.sql             # Consulta: Top 3 cursos com melhor média
└── populacao_teste/
    ├── 01_inserir_categorias.sql
    ├── 02_inserir_cursos.sql
    ├── 03_inserir_alunos.sql
    ├── 04_inserir_inscricoes.sql
    └── 05_inserir_avaliacoes.sql
```

## Requisitos

- MySQL 5.7+ ou MySQL 8.0+
- Acesso ao servidor MySQL com permissões para criar banco de dados e tabelas

## Instalação e Execução

### 1. Criar o Banco de Dados e Tabelas

Execute os scripts SQL na ordem numérica:

```bash
mysql -u seu_usuario -p < sql/01_criar_banco.sql
mysql -u seu_usuario -p < sql/02_criar_tabela_categorias.sql
mysql -u seu_usuario -p < sql/03_criar_tabela_cursos.sql
mysql -u seu_usuario -p < sql/04_criar_tabela_alunos.sql
mysql -u seu_usuario -p < sql/05_criar_tabela_inscricoes.sql
mysql -u seu_usuario -p < sql/06_criar_tabela_avaliacoes.sql
```

Ou execute todos de uma vez:

```bash
mysql -u seu_usuario -p < sql/01_criar_banco.sql
mysql -u seu_usuario -p dbtechcourses < sql/02_criar_tabela_categorias.sql
mysql -u seu_usuario -p dbtechcourses < sql/03_criar_tabela_cursos.sql
mysql -u seu_usuario -p dbtechcourses < sql/04_criar_tabela_alunos.sql
mysql -u seu_usuario -p dbtechcourses < sql/05_criar_tabela_inscricoes.sql
mysql -u seu_usuario -p dbtechcourses < sql/06_criar_tabela_avaliacoes.sql
```

### 2. Popular o Banco de Dados

Execute os scripts de inserção na ordem:

```bash
mysql -u seu_usuario -p dbtechcourses < populacao_teste/01_inserir_categorias.sql
mysql -u seu_usuario -p dbtechcourses < populacao_teste/02_inserir_cursos.sql
mysql -u seu_usuario -p dbtechcourses < populacao_teste/03_inserir_alunos.sql
mysql -u seu_usuario -p dbtechcourses < populacao_teste/04_inserir_inscricoes.sql
mysql -u seu_usuario -p dbtechcourses < populacao_teste/05_inserir_avaliacoes.sql
```

### 3. Executar Consultas

Execute as consultas SQL obrigatórias:

```bash
mysql -u seu_usuario -p dbtechcourses < sql/07_consulta_a.sql
mysql -u seu_usuario -p dbtechcourses < sql/08_consulta_b.sql
mysql -u seu_usuario -p dbtechcourses < sql/09_consulta_c.sql
mysql -u seu_usuario -p dbtechcourses < sql/10_consulta_d.sql
```

## Modelo de Dados

### Entidades Principais

1. **Categorias**: Categorias dos cursos (IA, Banco de Dados, etc.)
2. **Cursos**: Cursos profissionalizantes oferecidos
3. **Alunos**: Dados dos alunos (nome, CPF, email, etc.)
4. **Inscrições**: Relação entre alunos e cursos com status (em_andamento/concluido)
5. **Avaliações**: Avaliações dos cursos concluídos

### Relacionamentos

- 1 Categoria possui N Cursos
- 1 Aluno possui N Inscrições
- 1 Curso possui N Inscrições
- 1 Inscrição possui 1 Avaliação (opcional, apenas se concluída)

## Características Técnicas

- **Normalização**: 3FN (Terceira Forma Normal)
- **Engine**: InnoDB
- **Charset**: utf8mb4
- **Collation**: utf8mb4_unicode_ci
- **Constraints**: 
  - UNIQUE em CPF e email de alunos
  - UNIQUE em inscricao_id de avaliações (relacionamento 1:1)
  - Trigger para validar que avaliação só existe para curso concluído

## Dados de Teste

O projeto inclui dados de teste com:
- 5 categorias
- 5 cursos
- 12 alunos
- 15 inscrições (10 concluídas, 5 em andamento)
- 10 avaliações

## Consultas Implementadas

1. **Consulta A**: Contagem de cursos concluídos vs em andamento
2. **Consulta B**: Quantidade de alunos por curso
3. **Consulta C**: Alunos que concluíram cursos com suas avaliações
4. **Consulta D**: Top 3 cursos com melhor média de avaliação

## Documentação

Consulte os arquivos em `docs/` para:
- **Diagrama DER visual** ([diagrama_der.md](docs/diagrama_der.md)): Diagrama entidade-relacionamento em formato Mermaid
- **Modelo conceitual e lógico** ([modelo_conceitual_logico.md](docs/modelo_conceitual_logico.md)): Documentação detalhada do modelo
- **Resultados das consultas** ([resultados_consultas.md](docs/resultados_consultas.md)): Resultados esperados das consultas SQL

## Autor

Projeto desenvolvido para a disciplina de Cognitive Data Science - FIAP

## Licença

Este projeto é parte de um trabalho acadêmico.

