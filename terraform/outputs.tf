output "s3_bucket_website_url" {
  value = aws_s3_bucket_website_configuration.frontend_website.website_endpoint
  description = "The URL of the S3 bucket hosting the static website"
}

output "bucket_name" {
  value       = aws_s3_bucket.frontend.id
  description = "The Name of the S3 Bucket"
}

output "backend_instance_public_ip" {
  value = aws_instance.backend.public_ip
  description = "The public IP address of the backend EC2 instance"
}
