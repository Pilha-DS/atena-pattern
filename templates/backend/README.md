# Template de API

Esqueleto mínimo de uma API com o padrão: configuração, áreas, Alembic,
`create_app` e um teste do envelope.

## Copiar

```bash
cp -r atena-pattern/templates/backend minha-api
cd minha-api
```

Depois:

1. renomeie o projeto em `pyproject.toml`;
2. ajuste a dependência `atena-pattern` (git com tag em produção; `path` em
   desenvolvimento local);
3. copie `.env.example` para `.env` e gere `SECRET_KEY`;
4. crie o ambiente e instale:

```bash
uv venv
uv sync
```

## Banco e migrations

```bash
uv run alembic revision --autogenerate -m "estrutura inicial"
uv run alembic upgrade head
```

A migration inicial inclui as tabelas do núcleo (`users`, `system_state`,
`api_secrets`, `secret_area_permissions`, `secret_audit_logs`) e as tabelas do
projeto. Toda alteração depois disso é uma migration nova.

## Rodar

```bash
uv run uvicorn app.main:app --reload
```

- `http://localhost:8000/health`
- `http://localhost:8000/docs`
- `POST /api/v1/auth/register` — o primeiro usuário vira ADMIN
- `POST /api/v1/auth/login` — devolve o JWT

## Próximos passos

1. criar o modelo do domínio com coluna `sensitivity`;
2. registrar a área em `app/core/areas.py`;
3. criar schema, repositório, serviço e rota (ver `docs/BACKEND.md`);
4. incluir a rota em `create_app(..., routers=[...])`;
5. escrever o teste da regra e o teste de permissão.

## Testar

```bash
uv run pytest
```
