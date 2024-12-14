#!/bin/bash
# Update packages and install Flask dependencies
sudo apt update -y
sudo apt install -y python3 python3-pip
# Install Flask
echo "Installing Flask..."
pip3 install flask

# Create /app directory if it doesn't exist (to ensure proper permissions)
echo "Creating /app directory..."
sudo mkdir -p /app
sudo chown -R $USER:$USER /app

aws s3 cp s3://navk-flask-frontend-bucket/index.html /app/index.html

# Clone the Flask app repository from GitHub (or download it)
echo "Cloning the repository..."
git clone https://github.com/navkaurneet/CICD-FinalProject-Nav.git /app/backend


# Start the Flask app
nohup python3 /app/backend/app.py > /app/backend/logs.txt 2>&1 &