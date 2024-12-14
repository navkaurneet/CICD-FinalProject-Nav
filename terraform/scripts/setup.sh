#!/bin/bash
# Update packages and install Flask dependencies
sudo apt update -y
sudo apt install -y python3 python3-pip
pip3 install flask

# Download the app
mkdir /app
aws s3 cp s3://my-flask-frontend-bucket/index.html /app/index.html

# Clone the Flask app repository (or download it)
# Assuming the Flask app code is in a GitHub repo
git clone https://github.com/navkaurneet/CICD-FinalProject-Nav.git /app/backend

# Start the Flask app
nohup python3 /app/backend/app.py > /app/backend/logs.txt 2>&1 &
