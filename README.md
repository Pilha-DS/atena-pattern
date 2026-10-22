# atena-pattern

Base de projetos do ecossistema Atena. **Fork, renomeie e construa.**

Um fork já vem pronto: a API e o app rodam, com o padrão aplicado — envelope
único, sessão, credenciais, permissões por área, tema, TOAT e cliente HTTP. O
domínio (notas, agenda, metas, catálogo) você constrói no `application/`.

```text
atena-pattern/            ← fork e renomeie
├── AGENTS.md             regras obrigatórias
├── .cursor/rules/        regras do editor (versionadas)
├── docs/                 arquitetura, backend, frontend, checklist
├── packages/
│   ├── atena_pattern/    núcleo Python compartilhado (envelope, sessão, acesso)
│   └── atena_ui/         package Flutter (tema, tokens, TOAT, widgets)
├── application/
│   ├── backend/          API do projeto (FastAPI + Alembic + Dockerfile)
│   └── frontend/         app do projeto (Flutter + Dockerfile + nginx)
├── docker-compose.yml    banco, API e app prontos para subir
├── .env.example          variáveis do compose
└── Makefile              atalhos (up, down, logs, migrate, test)
```

`packages/` é o que é transversal: não conhece o produto. `application/` é o
produto: é onde o domínio entra. Cada camada só importa a de baixo.

## Por que fork

O fork é o modelo de distribuição. Você recebe o padrão inteiro, com o esqueleto
já funcionando, e evolui o produto no mesmo repositório.

| Alternativa | Problema |
| --- | --- |
| instalar a biblioteca por git | o esqueleto (Alembic, cliente HTTP, features) continua sem ponto de partida |
| copiar pastas soltas | cada projeto diverge; correção de permissão vira trabalho manual em N lugares |
| monorepo de exemplo | clonar e renomear não versiona o padrão junto com o produto |

O fork mantém as três coisas juntas: padrão, esqueleto e produto. Uma correção no
núcleo vale para o produto na hora, sem publicar versão.

## Começar

```bash
git clone git@github.com:Pilha-DS/atena-pattern.git meu-projeto
cd meu-projeto
rm -rf .git && git init
```

Renomeie a identidade:

1. `application/backend/pyproject.toml` — `name` do projeto;
2. `application/frontend/pubspec.yaml` — `name` do app (e os imports
   `package:<name>/...`);
3. `application/frontend/lib/src/core/config/app_config.dart` — nome e URL da API;
4. `application/frontend/lib/src/app.dart` — paleta da marca;
5. `.env` na raiz — a partir do `.env.example` (`make env` já cria), com
   `SECRET_KEY` gerada.

### Docker (recomendado)

```bash
make env     # cria .env a partir do exemplo
make up      # banco + API + app
```

- app em `http://localhost:8080`
- API em `http://localhost:8000` (`/docs`)
- MySQL em `localhost:3306`

`make logs` acompanha, `make migrate` aplica migration no container, `make down`
para e `make clean` apaga o volume do banco. O `web` serve o Flutter buildado e
encaminha `/api` para o `api` — mesma origem, sem CORS. A API roda
`alembic upgrade head` no start, então banco novo já sobe migrado.

| Serviço | Imagem | Papel |
| --- | --- | --- |
| `db` | `mysql:8.4` | banco com volume persistente e healthcheck |
| `api` | `application/backend/Dockerfile` | FastAPI com migration no boot |
| `web` | `application/frontend/Dockerfile` | Flutter web + nginx (`/api` → `api:8000`) |

Por padrão o app usa a própria origem e o `web` faz proxy de `/api`. Para servir o
app em outro domínio, defina `API_PUBLIC_URL` no `.env`.

### Local, sem Docker

```bash
# API
cd application/backend
cp .env.example .env
uv venv && uv sync
uv run alembic upgrade head
uv run uvicorn app.main:app --reload

# App
cd application/frontend
flutter pub get
flutter run
```

A primeira requisição a `/api/v1/auth/register` cria o usuário ADMIN. `/docs`
mostra a API.

## Como o padrão se liga ao produto

- `application/backend` importa `atena_pattern` por caminho
  (`tool.uv.sources`), então mexer no núcleo reflete no produto sem reinstalar.
- `application/frontend` importa `atena_ui` por caminho no `pubspec.yaml`.
- Área nova no domínio: registre em `application/backend/app/core/areas.py`.
- Widget novo: nasce em `packages/atena_ui`, não no app.

Detalhe de cada camada em `docs/BACKEND.md` e `docs/FRONTEND.md`.

## Regras do editor (`.cursor`)

`.cursor/rules/` é padrão versionado, não preferência local: é o que faz o editor
carregar a regra certa por área antes de qualquer alteração.

```text
.cursor/rules/
├── pattern.mdc    sempre ativo: ler README + AGENTS + PATTERN
├── backend.mdc    em packages/atena_pattern/** e application/backend/**
├── frontend.mdc   em packages/atena_ui/** e application/frontend/**
└── docs.mdc       em docs/** e nos arquivos de regra
```

A regra sempre ativa não repete as regras: ela redireciona para `AGENTS.md`.

## Regra de ouro

Um padrão por assunto. Se o padrão existe (envelope, TOAT, erro, estado de tela,
nome de pasta), use-o e siga exatamente a forma dele. Se não existe, crie **um**
padrão reutilizável (em `packages/`) e passe a usá-lo. Nunca conviva com dois
formatos para a mesma coisa.

## Estado atual

- [x] núcleo `atena_pattern`: envelope, sessão, usuários, credenciais e
      permissões por área;
- [x] package `atena_ui`: tema parametrizável, TOAT, widgets e níveis de
      sensibilidade;
- [x] API e app funcionando no fork, com Alembic e cliente do envelope;
- [x] regras, `.cursor` e documentação;
- [x] Docker: compose com banco, API e app, mais `Makefile`;
- [ ] CI de referência;
- [ ] migração do Modern-Diary para o modelo de fork.

O `Modern-Diary` é a referência de uso real e o primeiro produto do padrão. Até a
migração, melhorias entram aqui; a cópia dele não evolui.
