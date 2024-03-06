
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

resource "aws_api_gateway_method" "serverless_demos_method" {
  rest_api_id   = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_resource.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_resource.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.satyam_lambda_function.invoke_arn}"
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.satyam_lambda_function.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.serverless_demos.id}/*/${aws_api_gateway_method.serverless_demos_method.http_method}${aws_api_gateway_resource.serverless_demos_resource.path}"
}



# ---------------------CoRS Integration
resource "aws_api_gateway_method_response" "method_response1" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_resource.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_method.http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "integration_response1" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_resource.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_method.http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }

    depends_on = [aws_api_gateway_integration.integration]
}
# -------------End Of Cors Integration





#---------------------------------------------Employee Resource Code--------------------------------------------------------------------------------------------
resource "aws_api_gateway_resource" "serverless_demos_employee" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  parent_id   = "${aws_api_gateway_rest_api.serverless_demos.root_resource_id}"
  path_part   = var.endpoint_path_employee
}



#---------------------------- post Method 
resource "aws_api_gateway_method" "serverless_demos_employee_GET" {
  rest_api_id   = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employee.id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration1" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employee.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_employee_GET.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.satyam_lambda_function.invoke_arn}"
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda1" {
  statement_id  = "AllowExecutionFromAPIGatewayGET"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.satyam_lambda_function.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.serverless_demos.id}/*/${aws_api_gateway_method.serverless_demos_employee_GET.http_method}${aws_api_gateway_resource.serverless_demos_employee.path}"
}


#---------------------------- Get Method 
resource "aws_api_gateway_method" "serverless_demos_employee_GET1" {
  rest_api_id   = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employee.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration2" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employee.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_employee_GET1.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.satyam_lambda_function.invoke_arn}"
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda2" {
  statement_id  = "AllowExecutionFromAPIGatewayGET1"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.satyam_lambda_function.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.serverless_demos.id}/*/${aws_api_gateway_method.serverless_demos_employee_GET1.http_method}${aws_api_gateway_resource.serverless_demos_employee.path}"
}



#---------------------------- Delete Method 
resource "aws_api_gateway_method" "serverless_demos_employee_GET2" {
  rest_api_id   = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employee.id}"
  http_method   = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration3" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employee.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_employee_GET2.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.satyam_lambda_function.invoke_arn}"
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda3" {
  statement_id  = "AllowExecutionFromAPIGatewayGET2"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.satyam_lambda_function.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.serverless_demos.id}/*/${aws_api_gateway_method.serverless_demos_employee_GET2.http_method}${aws_api_gateway_resource.serverless_demos_employee.path}"
}







#---------------------------- PATCH Method 
resource "aws_api_gateway_method" "serverless_demos_employee_GET3" {
  rest_api_id   = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employee.id}"
  http_method   = "PATCH"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration4" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employee.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_employee_GET3.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.satyam_lambda_function.invoke_arn}"
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda4" {
  statement_id  = "AllowExecutionFromAPIGatewayGET3"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.satyam_lambda_function.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.serverless_demos.id}/*/${aws_api_gateway_method.serverless_demos_employee_GET3.http_method}${aws_api_gateway_resource.serverless_demos_employee.path}"
}















#---------------------------------------------Employees Resource Code--------------------------------------------------------------------------------------------
resource "aws_api_gateway_resource" "serverless_demos_employees" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  parent_id   = "${aws_api_gateway_rest_api.serverless_demos.root_resource_id}"
  path_part   = var.endpoint_path_employees
}



#---------------------------- GET Method 
resource "aws_api_gateway_method" "serverless_demos_employee_GET4" {
  rest_api_id   = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employees.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration5" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employees.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_employee_GET4.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.satyam_lambda_function.invoke_arn}"
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda5" {
  statement_id  = "AllowExecutionFromAPIGatewayGET4"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.satyam_lambda_function.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.serverless_demos.id}/*/${aws_api_gateway_method.serverless_demos_employee_GET4.http_method}${aws_api_gateway_resource.serverless_demos_employees.path}"
}



















resource "aws_api_gateway_deployment" "satyam_deployement" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"

  
    triggers = {
    redeployment = sha1(jsonencode([
        aws_api_gateway_resource.serverless_demos_resource.id,
        aws_api_gateway_method.serverless_demos_method.id,
        aws_api_gateway_integration.integration.id,

        aws_api_gateway_resource.serverless_demos_employee.id,
        aws_api_gateway_method.serverless_demos_employee_GET.id,
        aws_api_gateway_integration.integration1.id,

        aws_api_gateway_resource.serverless_demos_employee.id,
        aws_api_gateway_method.serverless_demos_employee_GET1.id,
        aws_api_gateway_integration.integration2.id,

        aws_api_gateway_resource.serverless_demos_employee.id,
        aws_api_gateway_method.serverless_demos_employee_GET2.id,
        aws_api_gateway_integration.integration3.id,

        aws_api_gateway_resource.serverless_demos_employee.id,
        aws_api_gateway_method.serverless_demos_employee_GET3.id,
        aws_api_gateway_integration.integration4.id,

        aws_api_gateway_resource.serverless_demos_employees.id,
        aws_api_gateway_method.serverless_demos_employee_GET4.id,
        aws_api_gateway_integration.integration5.id
    ]))
  }

    lifecycle {
      create_before_destroy = true
    }
    depends_on = [
        aws_api_gateway_method.serverless_demos_method,
        aws_api_gateway_integration.integration,
        aws_api_gateway_integration.integration1,
        aws_api_gateway_integration.integration2,
        aws_api_gateway_integration.integration3,
        aws_api_gateway_integration.integration4,
        aws_api_gateway_integration.integration5
    ]

}

resource "aws_api_gateway_stage" "satyam_stage" {
  deployment_id = aws_api_gateway_deployment.satyam_deployement.id
  rest_api_id = aws_api_gateway_rest_api.serverless_demos.id
  stage_name = "dev"
}

