# We create a lambda fucntion which access a ecr image
resource "aws_lambda_function" "satyam_lambda_function" {
  depends_on = [ null_resource.default ]
  function_name    = "satyam_lambda_function"
  architectures = [ "arm64" ]
  package_type     = "Image"
  image_uri        = "${aws_ecr_repository.satyam_project.repository_url}:latest"
  role             = aws_iam_role.satyam_lambda_execution_role.arn
}
