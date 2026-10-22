from atena_pattern import create_app

from app.core.areas import register_areas
from app.core.config import Settings

register_areas()

app = create_app(Settings(), title="Atena App")
