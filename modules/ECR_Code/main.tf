# ECR
resource "aws_ecr_repository" "satyam_project" {
  name = var.ecr_name
  image_tag_mutability = "MUTABLE" 
}
