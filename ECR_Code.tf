# ECR
resource "aws_ecr_repository" "satyam_project" {
  name = var.ecr_name
  image_tag_mutability = "IMMUTABLE" #using this we can make a private Registry
}

# Code used to deploy an image to ECR using a shell file
resource "null_resource" "push_docker_image_to_ecr" {

  depends_on = [aws_ecr_repository.satyam_project]
  provisioner "local-exec" {
    # command = "chmod +x ./scripts/run_command.sh"
    # command = "bash ./scripts/run_command.sh"
    command = "chmod +x ./scripts/run_command.sh && bash ./scripts/run_command.sh"
  }
}
