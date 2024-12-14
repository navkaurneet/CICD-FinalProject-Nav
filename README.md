# Simple Flask Application
# By Navneet Kaur
## Description
A basic Flask application with:
- A frontend (HTML) served via Flask.
- A backend API `/api/health` returning a simple JSON response.

## File Structure
project/ 
├── app/ 
│ ├── static/ 
│ │ └── index.html 
│ └── app.py 
├── requirements.txt 
└── README.md

markdown
Copy code

## Running the Application
1. Install dependencies:

   pip install -r requirements.txt

Run the app:

    python app/app.py

Open a browser and navigate to http://localhost:5000.

To create and run the virtual python environment 
    python -m venv venv
    source venv/Scripts/activate

## Features
API Endpoint: /api/health
Returns { "status": "healthy" }.
Frontend: Displays backend status.

## Infrastructure Plan
I'll provision the following on AWS:

Frontend: An S3 bucket to serve the static index.html.
Backend: An EC2 instance to run the Flask app.
API Gateway: To expose the backend API /api/health.
Networking: Security Groups and IAM roles for secure access.

## Prerequisites
- AWS account with necessary permissions.
- GitHub Secrets for AWS credentials:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
- Python 3.x installed locally.

## How to Run
1. Clone the repository:

   git clone https://github.com/your-repo/flask-app.git
   cd flask-app
Push changes to dev or main branch to trigger the CI/CD pipeline.

Monitor the GitHub Actions pipeline to ensure all steps pass.

## Test Cases
Test cases are located in app/test_app.py and can be executed locally using:

    pytest app/test_app.py

## Deployment
The pipeline deploys:
    -Frontend to an S3 bucket.
    -Backend to an EC2 instance running the Flask app.