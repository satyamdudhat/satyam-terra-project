provider "aws" {
  profile = var.profile
}


# ApiGateway Table Resource Code
module "api_gateway" {
  source           = "./modules/Api_Gateway"
  api_name         = lookup(var.Resource_name,"api_name","")
  uri              = module.Lambda_function.invoke_arn
  function_name    = module.Lambda_function.arn
}


# DynamoDB Table Resource Code
module "dynamoDB_table" {
  source = "./modules/DynamoDB"
  table_name = lookup(var.Resource_name,"table_name","")
}


# ECR Repo Code
module "Ecr_repo" {
  source = "./modules/ECR"
  ecr_name = lookup(var.Resource_name,"ecr_name","")
  image_tag_mutability = "MUTABLE"
}


# Lambda Code
module "Lambda_function" {
  function_name = lookup(var.Resource_name,"function_name","")
  source = "./modules/Lambda_Function"
  image_uri = "${module.Ecr_repo.repository_url}:latest"
  iam_role_name="satyam_lambda_execution_role"
  ecr_access_policy="satyam_lambda_ecr_access_policy"
  dyanmodb_access_policy="satyam_DynamoDb_access_policy"
  cloudwatch_access_policy="satyam_cloudwatch_logs_policy"
}