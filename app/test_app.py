import pytest
from app import app  # Import your Flask app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client  # This will allow you to use the client in tests

def test_homepage(client):
    response = client.get('/')
    print(response.data)  # Debugging output to check the response content
    assert response.status_code == 200
    assert b'Hello from Flask on EC2!' in response.data  # Ensure the response contains the text

def test_non_existent_page(client):
    response = client.get('/non-existent')
    assert response.status_code == 404  # Ensure it returns 404 for non-existent pages

def test_healthcheck(client):
    response = client.get('/health')
    print(response.data)  # Debugging output to check the response content
    assert response.status_code == 200
    assert b'OK' in response.data  # Ensure the response contains 'OK'

def test_post_data(client):
    response = client.post('/data', json={'key': 'value'})
    print(response.json)  # Debugging output to check the response JSON
    assert response.status_code == 200
    assert response.json == {'received': {'key': 'value'}}  # Ensure the response matches the expected

def test_flask_headers(client):
    response = client.get('/')
    assert 'Content-Type' in response.headers
    assert response.headers['Content-Type'] == 'text/html; charset=utf-8'
