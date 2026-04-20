from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"message": "Healthy"}

def test_version():
    response = client.get("/version")
    assert response.status_code == 200
    assert response.json() == {"message": "v0.1"}