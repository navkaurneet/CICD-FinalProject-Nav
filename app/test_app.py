import pytest
from app import app  # Import the Flask app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client  # This will allow you to use the client in tests

def test_homepage(client):
    response = client.get('/')
    print(response.data)  # Debugging output to check the response content
    assert response.status_code == 200
    assert b'Welcome to the Flask App' in response.data  # Ensure the page contains this text

def test_non_existent_page(client):
    response = client.get('/non-existent')
    assert response.status_code == 404  # Ensure it returns 404 for non-existent pages

def test_healthcheck(client):
    response = client.get('/api/health')  # Update to match your actual route
    print(response.data)  # Debugging output to check the response content
    assert response.status_code == 200
    assert b'"status": "healthy"' in response.data  # Ensure it returns the expected health status

def test_post_data(client):
    response = client.post('/data', json={'key': 'value'})
    print(response.json)  # Debugging output to check the response JSON
    assert response.status_code == 200  # This should return 200 if '/data' is implemented
    assert response.json == {'received': {'key': 'value'}}  # Ensure the response matches the expected

def test_flask_headers(client):
    response = client.get('/')
    assert 'Content-Type' in response.headers
    assert response.headers['Content-Type'] == 'text/html; charset=utf-8'
