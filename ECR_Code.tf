# ECR
resource "aws_ecr_repository" "satyam_project" {
  name = var.ecr_name
  image_tag_mutability = "IMMUTABLE" #using this we can make a private Registry

  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password --region ap-south-1 --profile satyam | docker login --username AWS --password-stdin 637423557273.dkr.ecr.ap-south-1.amazonaws.com
      docker build -t satyam_project --platform linux/arm64 .
      docker tag satyam_project 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest
      docker push 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest

    EOT
  }
}

# Code used to deploy an image to ECR using a shell file
# resource "null_resource" "push_docker_image_to_ecr" {

#   depends_on = [aws_ecr_repository.satyam_project]
#   provisioner "local-exec" {
#     command = "bash ./scripts/run_command.sh"
#   }
# }

# resource "null_resource" "build_and_push_docker_image" {
#   # triggers = {
#   #   # You can set triggers here if needed
#   # }
  
  
# }