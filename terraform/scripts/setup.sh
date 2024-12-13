#!/bin/bash
yum update -y
yum install python3 -y
pip3 install flask
cat <<EOF > /home/ec2-user/app.py
from flask import Flask
app = Flask(__name__)
@app.route("/")
def hello():
    return "Hello from Flask on EC2!"
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF
python3 /home/ec2-user/app.py &
