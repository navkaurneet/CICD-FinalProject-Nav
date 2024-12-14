import pytest
from app import app  # Assuming your Flask app is named `app.py`

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_homepage(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b'Welcome to the Flask App' in response.data  # Ensure the page contains this text

def test_non_existent_page(client):
    response = client.get('/non-existent')
    assert response.status_code == 404  # Ensure it returns 404 for non-existent pages

def test_healthcheck(client):
    response = client.get('/api/health')  # Update to match your actual route
    assert response.status_code == 200
    assert b'"status": "healthy"' in response.data.strip()  # Strip to remove any extra newlines or spaces

def test_post_data(client):
    # Assuming the '/data' route doesn't exist, expecting a 404 status code
    response = client.post('/data', json={'key': 'value'})
    assert response.status_code == 404  # Expecting 404 since '/data' doesn't exist

def test_flask_headers(client):
    response = client.get('/')
    assert 'Content-Type' in response.headers
    assert response.headers['Content-Type'] == 'text/html; charset=utf-8'
