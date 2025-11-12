# Modelo Conceitual e Lógico - Banco de Dados Cursos Profissionalizantes

## Modelo Conceitual

### Descrição Geral
Sistema de banco de dados relacional para gerenciar cursos profissionalizantes, alunos, inscrições e avaliações. O sistema permite acompanhar o status de cada curso para cada aluno (em andamento ou concluído) e registrar avaliações dos cursos concluídos.

### Entidades e Atributos

#### 1. CATEGORIA
- **Descrição**: Representa as categorias dos cursos oferecidos
- **Atributos**:
  - `id`: Identificador único (chave primária)
  - `nome`: Nome da categoria (único, obrigatório)
- **Exemplos**: IA, Banco de Dados, Desenvolvimento Web, etc.

#### 2. CURSO
- **Descrição**: Representa os cursos profissionalizantes oferecidos
- **Atributos**:
  - `id`: Identificador único (chave primária)
  - `nome`: Nome do curso (obrigatório)
  - `descricao`: Descrição detalhada do curso
  - `categoria_id`: Referência à categoria (chave estrangeira, obrigatório)
- **Relacionamento**: N cursos pertencem a 1 categoria

#### 3. ALUNO
- **Descrição**: Representa os alunos que se inscrevem nos cursos
- **Atributos**:
  - `id`: Identificador único (chave primária)
  - `nome`: Primeiro nome do aluno (obrigatório)
  - `sobrenome`: Sobrenome do aluno (obrigatório)
  - `cpf`: CPF do aluno (único, obrigatório, formato: 11 dígitos)
  - `email`: E-mail do aluno (único, obrigatório)
  - `data_nascimento`: Data de nascimento do aluno (obrigatório)
- **Relacionamento**: 1 aluno pode ter N inscrições

#### 4. INSCRIÇÃO
- **Descrição**: Representa a relação entre aluno e curso, incluindo o status
- **Atributos**:
  - `id`: Identificador único (chave primária)
  - `aluno_id`: Referência ao aluno (chave estrangeira, obrigatório)
  - `curso_id`: Referência ao curso (chave estrangeira, obrigatório)
  - `status`: Status da inscrição (ENUM: 'em_andamento' ou 'concluido', obrigatório)
  - `data_inscricao`: Data em que a inscrição foi realizada (obrigatório)
- **Relacionamentos**: 
  - N inscrições pertencem a 1 aluno
  - N inscrições pertencem a 1 curso
- **Regra de Negócio**: Um aluno não pode ter múltiplas inscrições ativas no mesmo curso

#### 5. AVALIAÇÃO
- **Descrição**: Representa a avaliação de um curso concluído por um aluno
- **Atributos**:
  - `id`: Identificador único (chave primária)
  - `inscricao_id`: Referência à inscrição (chave estrangeira, único, obrigatório)
  - `nota`: Nota atribuída ao curso (DECIMAL, obrigatório)
  - `comentario`: Comentário sobre o curso (TEXT, opcional)
  - `data_avaliacao`: Data em que a avaliação foi realizada (obrigatório)
- **Relacionamento**: 1 inscrição pode ter 1 avaliação (relacionamento 1:1)
- **Regra de Negócio**: Avaliação só pode existir para inscrições com status 'concluido'

### Diagrama de Relacionamentos

Para visualização completa do diagrama entidade-relacionamento (DER), consulte o arquivo [diagrama_der.md](diagrama_der.md) que contém o diagrama visual em formato Mermaid.

Representação textual dos relacionamentos:

```
CATEGORIA (1) ----< (N) CURSO
                         |
                         | (N)
                         |
                    INSCRIÇÃO
                         |
                         | (N)        (1)
                         |              |
                    ALUNO (1) ----< (N) INSCRIÇÃO
                                        |
                                        | (1)
                                        |
                                   AVALIAÇÃO (1)
```

## Modelo Lógico (3FN - Terceira Forma Normal)

### Normalização

O modelo está normalizado até a 3FN:

1. **1FN (Primeira Forma Normal)**: Todos os atributos são atômicos e não há grupos repetitivos
2. **2FN (Segunda Forma Normal)**: Todas as dependências parciais foram eliminadas através da separação de categorias em tabela própria
3. **3FN (Terceira Forma Normal)**: Todas as dependências transitivas foram eliminadas

### Estrutura das Tabelas

#### Tabela: `categorias`
```sql
categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
)
```

#### Tabela: `cursos`
```sql
cursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    descricao TEXT,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
)
```

#### Tabela: `alunos`
```sql
alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL
)
```

#### Tabela: `inscricoes`
```sql
inscricoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT NOT NULL,
    curso_id INT NOT NULL,
    status ENUM('em_andamento', 'concluido') NOT NULL,
    data_inscricao DATE NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id),
    UNIQUE KEY uk_aluno_curso (aluno_id, curso_id)
)
```

#### Tabela: `avaliacoes`
```sql
avaliacoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    inscricao_id INT NOT NULL UNIQUE,
    nota DECIMAL(4,2) NOT NULL,
    comentario TEXT,
    data_avaliacao DATE NOT NULL,
    FOREIGN KEY (inscricao_id) REFERENCES inscricoes(id)
)
```

### Índices

- Índices primários: `id` em todas as tabelas
- Índices únicos: `cpf` e `email` em `alunos`, `nome` em `categorias`, `inscricao_id` em `avaliacoes`
- Índices de chave estrangeira: `categoria_id`, `aluno_id`, `curso_id`, `inscricao_id`
- Índice composto: `(aluno_id, curso_id)` em `inscricoes` para garantir unicidade

### Constraints e Regras de Integridade

1. **Integridade Referencial**: Todas as chaves estrangeiras têm integridade referencial garantida
2. **Unicidade**: CPF e email de alunos são únicos; nome de categoria é único
3. **Validação de Status**: Status de inscrição é validado através de ENUM
4. **Validação de Avaliação**: Avaliação só pode ser criada para inscrição com status 'concluido' (será implementado via trigger ou aplicação)

### Visualização do Diagrama

O projeto inclui um diagrama visual completo em formato Mermaid disponível em [diagrama_der.md](diagrama_der.md). Este diagrama pode ser visualizado em:
- GitHub (renderiza Mermaid automaticamente)
- Visual Studio Code (com extensão Mermaid)
- Editores online como mermaid.live

#### Diagrama MySQL Workbench

Para visualizar o diagrama no MySQL Workbench:
1. Execute os scripts de criação das tabelas
2. Use a opção "Database" > "Reverse Engineer" para gerar o diagrama automaticamente
3. Ou importe o modelo através da funcionalidade de modelagem do MySQL Workbench

O diagrama mostrará:
- 5 tabelas: categorias, cursos, alunos, inscricoes, avaliacoes
- Relacionamentos 1:N entre categoria e cursos
- Relacionamentos N:M entre alunos e cursos (através de inscricoes)
- Relacionamento 1:1 entre inscricoes e avaliacoes

