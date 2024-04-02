provider "aws" {
  profile = var.profile
}


# ApiGateway Table Resource Code
module "api_gateway" {
  source           = "./modules/api_gateway"
  api_name         = "EmployeeInfo"
  uri              = module.Lambda_function.invoke_arn
  function_name    = module.Lambda_function.arn
}


# DynamoDB Table Resource Code
module "dynamoDB_table" {
  source = "./modules/DynamoDB"
  table_name = "employee_infos"
}


# ECR Repo Code
module "Ecr_repo" {
  source = "./modules/ECR_Code"
  ecr_name = "satyam_project"
}



# Lambda Code
module "Lambda_function" {
  source = "./modules/lambda"
  image_uri = "${module.Ecr_repo.repository_url}:latest"
}
