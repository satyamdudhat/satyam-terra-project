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
  default = {"1":"status", "2":"employee", "3":"employees"}
}