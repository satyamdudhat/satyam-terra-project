
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
  function_name = "${aws_lambda_function.satyam_lambda_function.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.serverless_demos.execution_arn}/*/${aws_api_gateway_method.serverless_demos_method.http_method}${aws_api_gateway_resource.serverless_demos_resource.path}"
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
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [aws_api_gateway_integration.integration]
}
# -------------End Of Cors Integration




























#---------------------------------------------Employee Resource Code--------------------------------------------------------------------------------------------
resource "aws_api_gateway_resource" "employee" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  parent_id   = "${aws_api_gateway_rest_api.serverless_demos.root_resource_id}"
  path_part   = var.endpoint_path_employee
}

resource "aws_api_gateway_method" "employee_method" {
  for_each = toset(["GET", "POST", "DELETE", "PATCH"])
  rest_api_id   = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.employee.id}"
  http_method   = each.key
  authorization = "NONE"
}

# Define CORS logic once
resource "aws_api_gateway_method_response" "cors_method_response" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id = "${aws_api_gateway_resource.employee.id}"
  http_method = "*"  # applies to all methods
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_integration_response" "cors_integration_response" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id = "${aws_api_gateway_resource.employee.id}"
  http_method = "*"  # applies to all methods
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# Define Lambda Integration with reusable CORS
resource "aws_api_gateway_integration" "integration1" {
  for_each = toset(["GET", "POST", "DELETE", "PATCH"])
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.employee.id}"
  http_method = each.key
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.satyam_lambda_function.invoke_arn}"
  depends_on             = [aws_api_gateway_integration_response.cors_integration_response]
}

# Lambda Permission (reference each integration)
resource "aws_lambda_permission" "lambda_permission" {
  for_each = toset(["GET", "POST", "DELETE", "PATCH"])
  statement_id  = "AllowExecutionFromAPIGateway_${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.satyam_lambda_function.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.serverless_demos.execution_arn}/*/${each.key}${aws_api_gateway_resource.employee.path}"
}






# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
































































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
  source_arn = "${aws_api_gateway_rest_api.serverless_demos.execution_arn}/*/${aws_api_gateway_method.serverless_demos_employee_GET4.http_method}${aws_api_gateway_resource.serverless_demos_employees.path}"
}


# ---------------------CoRS Integration employees
resource "aws_api_gateway_method_response" "method_response6" {
 rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employees.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_employee_GET4.http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "integration_response6" {
 rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"
  resource_id   = "${aws_api_gateway_resource.serverless_demos_employees.id}"
  http_method = "${aws_api_gateway_method.serverless_demos_employee_GET4.http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.integration5]
}
# -------------End Of Cors Integration































# ----------------------------Deployement Code--------------------------------------------

resource "aws_api_gateway_deployment" "satyam_deployement" {
  rest_api_id = "${aws_api_gateway_rest_api.serverless_demos.id}"

  
    triggers = {
    redeployment = sha1(jsonencode([
        aws_api_gateway_resource.serverless_demos_resource.id,
        aws_api_gateway_method.serverless_demos_method.id,
        aws_api_gateway_integration.integration.id,

        aws_api_gateway_resource.employee.id,
        aws_api_gateway_method.employee_method.id,
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




# -----------------Stage Code----------------------------------------------------
resource "aws_api_gateway_stage" "satyam_stage" {
  deployment_id = aws_api_gateway_deployment.satyam_deployement.id
  rest_api_id = aws_api_gateway_rest_api.serverless_demos.id
  stage_name = "dev"
}

