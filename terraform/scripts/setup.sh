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

# Clone the Flask app repository from GitHub (or download it)
echo "Cloning the repository..."
git clone https://github.com/navkaurneet/CICD-FinalProject-Nav.git /app/backend

# Check if the clone was successful
if [ ! -d "/app/backend" ]; then
    echo "Failed to clone the repository."
    exit 1
fi

# Copy the index.html file from the cloned repository to the /app directory
echo "Copying index.html to /app directory..."
cp /app/backend/app/static/index.html /app/index.html

# Check if the file copy was successful
if [ ! -f "/app/index.html" ]; then
    echo "Failed to copy index.html."
    exit 1
fi

# Start the Flask app in the background and log the output
echo "Starting the Flask app..."
nohup python3 /app/backend/app.py > /app/backend/logs.txt 2>&1 &

# Confirm the Flask app has started
if pgrep -f "python3 /app/backend/app.py" > /dev/null; then
    echo "Flask app started successfully."
else
    echo "Failed to start the Flask app."
    exit 1
fi
