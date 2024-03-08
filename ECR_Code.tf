# ECR
resource "aws_ecr_repository" "satyam_project" {
  name = var.ecr_name
  image_tag_mutability = "MUTABLE" #using this we can make a private Registry
  
}

resource "null_resource" "default" {

  # depends_on = [aws_ecr_repository.satyam_project]
  provisioner "local-exec" {
    command = "bash ./scripts/run_command.sh"
  }
} 
