from pathlib import Path

from alembic import command
from alembic.config import Config
from sqlalchemy import create_engine, inspect, text


def test_migrations_aplicam_do_zero(tmp_path, monkeypatch) -> None:
    database = tmp_path / "test.db"
    monkeypatch.setenv("DATABASE_URL", f"sqlite:///{database}")
    monkeypatch.setenv("SECRET_KEY", "chave-de-teste-com-mais-de-32-caracteres")

    command.upgrade(Config("alembic.ini"), "head")

    engine = create_engine(f"sqlite:///{database}")
    tables = set(inspect(engine).get_table_names())
    assert {
        "users",
        "system_state",
        "api_secrets",
        "secret_area_permissions",
        "secret_audit_logs",
    } <= tables

    # O primeiro cadastro depende desta linha única; sem ela, register dá 500.
    with engine.connect() as connection:
        admin_created = connection.execute(
            text("select admin_created from system_state where id = 1")
        ).scalar()
    assert admin_created is not None
    assert not admin_created


def test_migration_nao_usa_default_do_sqlite() -> None:
    for migration in Path("alembic/versions").glob("*.py"):
        assert "(CURRENT_TIMESTAMP)" not in migration.read_text()
