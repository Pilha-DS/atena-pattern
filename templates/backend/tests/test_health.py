from fastapi.testclient import TestClient

from atena_pattern import AthenaSettings, create_app


def make_client() -> TestClient:
    settings = AthenaSettings(
        environment="test",
        database_url="sqlite://",
        secret_key="test-secret-key-with-at-least-32-characters",
    )
    return TestClient(create_app(settings))


def test_health_responde_no_envelope() -> None:
    response = make_client().get("/health")

    assert response.status_code == 200
    body = response.json()
    assert body["success"] is True
    assert body["code"] == "HEALTHY"
    assert body["data"] == {"status": "ok"}
    assert body["request_id"]
