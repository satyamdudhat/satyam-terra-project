variable "api_name" {
  description = "Name for the API Gateway"
}



variable "uri" {
  description = "Lambda function invoke_arn"
  type = string
}

variable "function_name" {
  description = "Lambda fucntion Name ARN"
  type = string
}









#---------------------------------- Status Methods
variable "endpoint_path" {
  description = "status endpoint path"
  type = string
  default = "status"
}
variable "http_methods_status" {
  type    = list(string)
  default = ["GET"]
}












#------------------------------------ Employee Methods
variable "employee_endpoint_path" {
  description = "employee endpoint path"
  type = string
  default = "employee"
}
variable "http_methods_employee" {
  type    = list(string)
  default = ["GET","POST","DELETE","PATCH","PUT"]
}





#------------------------------------ Employees Methods
variable "employees_endpoint_path" {
  description = "employees endpoint path"
  type = string
  default = "employees"
}
variable "http_methods_employees" {
  type    = list(string)
  default = ["GET"]
}