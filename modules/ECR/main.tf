# ECR
resource "aws_ecr_repository" "ecr_repo" {
  name = var.ecr_name
  image_tag_mutability = var.image_tag_mutability 
}
