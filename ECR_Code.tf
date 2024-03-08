# ECR
resource "aws_ecr_repository" "satyam_project" {
  name = var.ecr_name
  image_tag_mutability = "MUTABLE" #using this we can make a private Registry
  
}

data "aws_ecr_image" "latest_image" {
  repository_name = aws_ecr_repository.satyam_project.name
  most_recent = true
}

resource "null_resource" "default" {

  # depends_on = [aws_ecr_repository.satyam_project]
  provisioner "local-exec" {
    command = "bash ./scripts/run_command.sh"
  }
} 
