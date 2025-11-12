# Diagrama Entidade-Relacionamento (DER)

## Diagrama Visual

```mermaid
erDiagram
    CATEGORIA ||--o{ CURSO : "possui"
    ALUNO ||--o{ INSCRICAO : "faz"
    CURSO ||--o{ INSCRICAO : "recebe"
    INSCRICAO ||--o| AVALIACAO : "tem"

    CATEGORIA {
        int id PK "Identificador único"
        varchar nome UK "Nome da categoria"
        timestamp created_at "Data de criação"
        timestamp updated_at "Data de atualização"
    }

    CURSO {
        int id PK "Identificador único"
        varchar nome "Nome do curso"
        text descricao "Descrição do curso"
        int categoria_id FK "Referência à categoria"
        timestamp created_at "Data de criação"
        timestamp updated_at "Data de atualização"
    }

    ALUNO {
        int id PK "Identificador único"
        varchar nome "Primeiro nome"
        varchar sobrenome "Sobrenome"
        varchar cpf UK "CPF (11 dígitos)"
        varchar email UK "E-mail"
        date data_nascimento "Data de nascimento"
        timestamp created_at "Data de criação"
        timestamp updated_at "Data de atualização"
    }

    INSCRICAO {
        int id PK "Identificador único"
        int aluno_id FK "Referência ao aluno"
        int curso_id FK "Referência ao curso"
        enum status "em_andamento ou concluido"
        date data_inscricao "Data da inscrição"
        timestamp created_at "Data de criação"
        timestamp updated_at "Data de atualização"
    }

    AVALIACAO {
        int id PK "Identificador único"
        int inscricao_id FK UK "Referência à inscrição"
        decimal nota "Nota de 0 a 10"
        text comentario "Comentário sobre o curso"
        date data_avaliacao "Data da avaliação"
        timestamp created_at "Data de criação"
        timestamp updated_at "Data de atualização"
    }
```

## Legenda

- **PK**: Chave Primária (Primary Key)
- **FK**: Chave Estrangeira (Foreign Key)
- **UK**: Único (Unique Key)

## Relacionamentos

1. **CATEGORIA → CURSO** (1:N)
   - Uma categoria pode ter vários cursos
   - Um curso pertence a uma única categoria

2. **ALUNO → INSCRICAO** (1:N)
   - Um aluno pode fazer várias inscrições
   - Uma inscrição pertence a um único aluno

3. **CURSO → INSCRICAO** (1:N)
   - Um curso pode receber várias inscrições
   - Uma inscrição pertence a um único curso

4. **INSCRICAO → AVALIACAO** (1:1)
   - Uma inscrição pode ter no máximo uma avaliação
   - Uma avaliação pertence a uma única inscrição
   - **Regra de negócio**: Avaliação só pode existir para inscrições com status "concluido"

## Observações

- O relacionamento entre ALUNO e CURSO é N:M (muitos para muitos), implementado através da entidade INSCRICAO
- A constraint UNIQUE em `inscricao_id` na tabela AVALIACAO garante o relacionamento 1:1
- O trigger `trg_avaliacao_inscricao_concluida` valida que apenas inscrições concluídas podem ter avaliações

## Visualização

Este diagrama pode ser visualizado em:
- GitHub (renderiza Mermaid automaticamente)
- Visual Studio Code (com extensão Mermaid)
- Editores online como mermaid.live
- MySQL Workbench (usando Database > Reverse Engineer após executar os scripts)

