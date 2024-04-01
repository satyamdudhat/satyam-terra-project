provider "aws" {
  profile = var.profile
}



module "api_gateway" {
  source           = "./modules/api_gateway"
  api_name         = "EmployeeInfo"
  uri              = aws_lambda_function.satyam_lambda_function.invoke_arn
  function_name    = aws_lambda_function.satyam_lambda_function.arn
}
