resource "aws_s3_bucket" "frontend" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "Frontend-Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.frontend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.block_public_access,
  ]

  bucket = aws_s3_bucket.frontend.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "frontend_website" {
  bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }
}

/*resource "aws_s3_object" "frontend_index" {
  bucket = aws_s3_bucket.frontend.id
  key    = "index.html"
  source = "C:/Users/user1/Documents/Navneet/CDevOps/Sem2/CI&CD/FinalProject-n1/app/static/index.html" 
}
*/
resource "aws_s3_object" "frontend_index" {
  bucket        = aws_s3_bucket.frontend.id
  key           = "index.html"
  source        = "../app/static/index.html"
  content_type  = "text/html"
}


/*resource "aws_instance" "backend" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = var.key_pair_name
  security_groups = [aws_security_group.allow_http.name]

  user_data = file("${path.module}/scripts/setup.sh")

  tags = {
    Name = "Flask-Backend"
  }
}
*/

resource "aws_instance" "backend" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = var.key_pair_name
  security_groups = [aws_security_group.allow_http.name]

  # Setup EC2 user-data script for running the Flask app
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y git python3
              pip3 install flask
              
              cd /home/ec2-user
              git clone https://github.com/navkaurneet/CICD-FinalProject-Nav.git flask_app

              aws s3 cp s3://your-s3-bucket-name/index.html /home/ec2-user/flask_app/app/static/index.html

              chown -R ec2-user:ec2-user /home/ec2-user/flask_app

              cd /home/ec2-user/flask_app
              nohup python3 app.py &
            EOF

  tags = {
    Name = "Flask-Backend"
  }
}


resource "aws_security_group" "allow_http" {
  name        = "allow_http_terraform_${random_id.sg_id.hex}"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "random_id" "sg_id" {
  byte_length = 4
}
