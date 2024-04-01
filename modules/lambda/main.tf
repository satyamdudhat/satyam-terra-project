resource "aws_lambda_function" "satyam_lambda_function" {
  function_name    = "satyam_lambda_function"
  architectures = ["x86_64"]
  package_type     = "Image"
  image_uri        = var.image_uri
  role             = aws_iam_role.satyam_lambda_execution_role.arn
}
