from fastapi.testclient import TestClient
from app.main import app
import pytest

client = TestClient(app)

@pytest.mark.integration
def test_db_integration():
    response = client.get("/db-check")
    assert response.status_code == 200
    assert response.json() == {"db_status": "ok", "result": 1}
