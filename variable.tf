# Account All Details
variable "profile" {
  type = string
}


variable "Resource_name" {
  type = map(string)
  default = {"api_name":"EmployeeInfo", "table_name":"employee_infos", "ecr_name":"satyam_project", "function_name":"satyam_lambda_function"}
}


variable "Api_path" {
  type = map(string)
  default = {"resource1":"status", "resource2":"employee", "resource3":"employees"}
}