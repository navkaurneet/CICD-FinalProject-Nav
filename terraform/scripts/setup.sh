#!/bin/bash
# Update packages and install Flask dependencies
sudo apt update -y
sudo apt install -y python3 python3-pip
pip3 install flask

# Clone the Flask app repository from GitHub (or download it)
git clone https://github.com/navkaurneet/CICD-FinalProject-Nav.git /app/backend

# Copy the index.html from the cloned repository to the desired location
cp /app/backend/app/static/index.html /app/index.html

# Start the Flask app in the background and log the output
nohup python3 /app/backend/app.py > /app/backend/logs.txt 2>&1 &
