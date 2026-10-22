# API do projeto

`application/backend` é a API do produto, fora do padrão. O que é transversal
(envelope, erro, sessão, credenciais, níveis, permissões) vem de
`packages/atena_pattern` por caminho — editar o núcleo reflete aqui direto.

```text
app/
├── main.py         create_app com as rotas do projeto
├── core/
│   ├── config.py   Settings(AthenaSettings)
│   └── areas.py    áreas protegidas por credencial
├── models/         tabelas do domínio
├── schemas/        contrato de entrada e saída
├── repositories/   acesso ao banco
├── services/       regra de negócio
└── api/routes/     rotas do projeto
alembic/            migrations versionadas
tests/              regra de negócio e permissão
```

## Rodar

```bash
cp .env.example .env      # gere SECRET_KEY: python -c "import secrets; print(secrets.token_urlsafe(48))"
uv venv
uv sync
uv run alembic upgrade head
uv run uvicorn app.main:app --reload
```

- `http://localhost:8000/health`
- `http://localhost:8000/docs`
- `POST /api/v1/auth/register` — o primeiro usuário vira ADMIN
- `POST /api/v1/auth/login` — devolve o JWT

## Domínio novo

1. modelo com coluna `sensitivity` (`SensitivityType`);
2. registre a área em `app/core/areas.py`;
3. schema, repositório, serviço e rota (ver `docs/BACKEND.md`);
4. inclua a rota em `create_app(..., routers=[...])`;
5. migration: `uv run alembic revision --autogenerate -m "..."`;
6. teste da regra e teste de permissão (área, nível e flag).

A migration inicial já inclui as tabelas do núcleo (`users`, `system_state`,
`api_secrets`, `secret_area_permissions`, `secret_audit_logs`).

## Testar

```bash
uv run pytest
```
