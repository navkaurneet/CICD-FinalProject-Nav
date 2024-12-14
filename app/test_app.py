import pytest
from app import app  # Assuming your Flask app is named `app.py`

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_homepage(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b'Hello from Flask on EC2!' in response.data

def test_non_existent_page(client):
    response = client.get('/non-existent')
    assert response.status_code == 404

def test_healthcheck(client):
    response = client.get('/health')
    assert response.status_code == 200
    assert b'OK' in response.data

def test_post_data(client):
    response = client.post('/data', json={'key': 'value'})
    assert response.status_code == 200
    assert response.json == {'received': {'key': 'value'}}

def test_flask_headers(client):
    response = client.get('/')
    assert 'Content-Type' in response.headers
    assert response.headers['Content-Type'] == 'text/html; charset=utf-8'
