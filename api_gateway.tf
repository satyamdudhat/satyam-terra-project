#---------------------------------------------Status Resource Code--------------------------------------------------------------------------------------------
resource "aws_api_gateway_rest_api" "serverless_demos" {
  name        = var.api_name
  description = "Terraform Serverless Application Example"
}

resource "aws_api_gateway_resource" "serverless_demos_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  parent_id   = "${aws_api_gateway_rest_api.serverless_demos.root_resource_id}"
  path_part   = var.endpoint_path
}

variable "http_methods" {
  default = ["GET", "PUT", "POST", "PATCH"]
}

resource "aws_api_gateway_method" "serverless_demos_method" {
  count = length(var.http_methods)
  authorization = "NONE"
  http_method   = var.http_methods[count.index]
  rest_api_id   = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_resource.id}"
 
}

resource "aws_api_gateway_integration" "integration" {
  count = length(var.http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_resource.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_method[count.index].http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.satyam_lambda_function.invoke_arn}"
}




# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda" {
  count = length(var.http_methods)
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.satyam_lambda_function.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.serverless_demos.execution_arn}/*/${aws_api_gateway_method.serverless_demos_method[count.index].http_method}${aws_api_gateway_resource.serverless_demos_resource.path}"
}


resource "aws_api_gateway_deployment" "satyam_deployement" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_method.serverless_demos_method[*].id))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "satyam_stage" {
  deployment_id = aws_api_gateway_deployment.satyam_deployement.id
  rest_api_id = aws_api_gateway_rest_api.serverless_demos.id
  stage_name = "dev"
}

