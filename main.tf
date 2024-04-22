provider "aws" {
  profile = var.profile
}


# ApiGateway Table Resource Code
module "api_gateway" {
  source           = "./modules/Api_Gateway"
  api_name         = var.api_name
  uri              = module.lambda_function.invoke_arn
  function_name    = module.lambda_function.arn
  api_path_name    = [ "status", "employee", "employees" ]
}


# DynamoDB Table Resource Code
module "dyanmo_db" {
  source = "./modules/Dynamo_DB"
  table_name = var.table_name
  hash_key_id = "employeeid"
}


# ECR Repo Code
module "ecr_repo" {
  source = "./modules/ECR"
  ecr_name = var.ecr_name
  image_tag_mutability = "MUTABLE"
}


# Lambda Code
module "lambda_function" {
  function_name = var.function_name
  source = "./modules/Lambda_Function"
  image_uri = "${module.ecr_repo.repository_url}:latest"
  iam_role_name = var.iam_role_name
  ecr_access_policy = var.ecr_access_policy
  dyanmodb_access_policy = var.dyanmodb_access_policy
  cloudwatch_access_policy = var.cloudwatch_access_policy
}