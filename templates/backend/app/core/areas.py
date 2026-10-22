"""Áreas protegidas por credencial neste projeto.

Cada tabela sensível tem uma coluna de nível. Registre a área aqui e use o
mesmo nome em `AccessGuard.visible(...)`, `ensure_create(...)` e
`ensure_write(...)`.

Exemplo:

    from app.models.note import Note

    def register_areas() -> None:
        areas.register("notes", Note.sensitivity)
"""

from atena_pattern.core.access import areas  # noqa: F401


def register_areas() -> None:
    """Registra as áreas do projeto no motor de permissões."""
