# atena-pattern

O padrão de desenvolvimento do ecossistema Atena, separado do produto que o
originou. Aqui vive o que **não é de domínio** e pode ser usado por projetos
totalmente diferentes:

- **regras** — `AGENTS.md` e `docs/`: como o software é construído;
- **backend** — biblioteca Python `atena-pattern`: envelope, erro, paginação,
  sessão, credenciais, níveis de sensibilidade e motor de permissões;
- **frontend** — package Flutter `atena_ui`: tema, tokens, TOAT e widgets.

O domínio (notas, agenda, metas, catálogo de qualquer produto) **não entra aqui**.
Ele fica no projeto que consome o padrão.

## Estrutura

```text
atena-pattern/
├── AGENTS.md               # regras obrigatórias para quem constrói
├── docs/
│   ├── PATTERN.md          # arquitetura e decisões
│   ├── BACKEND.md          # como montar uma API com a biblioteca
│   ├── FRONTEND.md         # como montar um app com o package
│   └── CHECKLIST.md        # conformidade de projeto e de PR
├── backend/                # atena-pattern (Python, FastAPI + SQLAlchemy)
│   ├── atena_pattern/
│   └── tests/
├── frontend/
│   └── atena_ui/           # package Flutter (um único package)
└── templates/
    ├── backend/            # esqueleto de API (config, áreas, Alembic)
    └── frontend/           # esqueleto de app (tema, TOAT, cliente HTTP)
```

O modelo de entrega é **híbrido**:

1. o que é transversal vira **biblioteca instalável** (backend) e **package**
   (frontend), para a correção valer em todos os projetos;
2. o que é esqueleto de projeto (Docker, Alembic, cliente HTTP do envelope,
   estrutura de features) vira **template**, copiado uma vez por projeto;
3. as **regras** valem para qualquer projeto, independentemente da stack.

## Consumir

### Backend

```toml
[project]
dependencies = [
  "atena-pattern @ git+ssh://git@github.com/Pilha-DS/atena-pattern.git@main#subdirectory=backend",
]
```

Em desenvolvimento local:

```toml
[tool.uv.sources]
atena-pattern = { path = "../atena-pattern/backend", editable = true }
```

### Frontend

```yaml
dependencies:
  atena_ui:
    git:
      url: git@github.com:Pilha-DS/atena-pattern.git
      path: frontend/atena_ui
      ref: main
```

Ou, em desenvolvimento, `path: ../atena-pattern/frontend/atena_ui`.

## Começar um projeto novo

```bash
cp -r atena-pattern/templates/backend minha-api
cp -r atena-pattern/templates/frontend meu-app
```

Cada template tem o próprio README com o passo a passo. Para o detalhe de cada
camada, use `docs/BACKEND.md` e `docs/FRONTEND.md`.

## Regra de ouro

Um padrão por assunto. Se o projeto já tem um padrão para aquilo, use o
existente e siga exatamente a forma dele. Se ainda não tem, crie **um** padrão
reutilizável (aqui, na biblioteca ou no package), registre e passe a usá-lo.
Nunca conviva com dois formatos para a mesma coisa.

## Estado atual

- [x] biblioteca backend com envelope, sessão, usuários, credenciais e
      permissões por área;
- [x] package `atena_ui` com tema parametrizável, TOAT, widgets e níveis de
      sensibilidade;
- [x] regras e documentação do padrão;
- [x] templates de backend (com Alembic) e de frontend (com cliente do envelope);
- [ ] Docker/CI de referência nos templates;
- [ ] migração do Modern-Diary para consumir a biblioteca e o package.

O `Modern-Diary` é o **primeiro consumidor** e a referência de uso real. Até a
migração dele, melhorias de padrão entram aqui; a cópia dele não evolui.
