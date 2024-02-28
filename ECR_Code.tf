# ECR
resource "aws_ecr_repository" "satyam_project" {
  name = var.ecr_name
  image_tag_mutability = "IMMUTABLE" #using this we can make a private Registry
}

# Code used to deploy an image to ECR using a shell file
# resource "null_resource" "push_docker_image_to_ecr" {

#   depends_on = [aws_ecr_repository.satyam_project]
#   provisioner "local-exec" {
#     command = "bash ./scripts/run_command.sh"
#   }
# }

resource "null_resource" "build_and_push_docker_image" {
  # triggers = {
  #   # You can set triggers here if needed
  # }
  
  provisioner "local-exec" {
    command = <<EOT
      # Log in to Amazon ECR
      aws ecr get-login-password --region ap-south-1 --profile satyam | docker login --username AWS --password-stdin 637423557273.dkr.ecr.ap-south-1.amazonaws.com

      # Build the Docker image
      docker build -t satyam_project --platform linux/arm64 .

      # Tag the Docker image
      docker tag satyam_project 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest

      # Push the Docker image to Amazon ECR
      docker push 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest
    EOT
  }
}