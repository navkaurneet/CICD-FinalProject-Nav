#!/bin/bash

# Update the system
yum update -y

# Install dependencies
yum install -y git python3 aws-cli

# Install CloudWatch Agent
yum install -y amazon-cloudwatch-agent

# Install Flask
pip3 install flask

# Clone the GitHub repository containing the Flask app
cd /home/ec2-user
git clone https://github.com/yourusername/your-repository.git flask_app

# Copy index.html from S3 (replace S3 bucket path with correct one)
aws s3 cp s3://your-s3-bucket-name/index.html /home/ec2-user/flask_app/app/static/index.html

# Change ownership for the cloned files
chown -R ec2-user:ec2-user /home/ec2-user/flask_app

# Configure CloudWatch Agent to collect logs
cat <<EOT > /home/ec2-user/cloudwatch-config.json
{
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/home/ec2-user/flask_app/app.log",
                        "log_group_name": "FlaskAppLogs",
                        "log_stream_name": "{instance_id}",
                        "timezone": "UTC"
                    }
                ]
            }
        }
    }
}
EOT

# Start the CloudWatch Agent with the configuration
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a stop
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start -c file:/home/ec2-user/cloudwatch-config.json

# Start the Flask app
cd /home/ec2-user/flask_app
nohup python3 app.py &

