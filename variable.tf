# Account All Details
variable "profile" {
  type = string
  default = "satyam"
}


variable "Resource_name" {
  type = map(string)
  default = {"api_name":"EmployeeInfo", "table_name":"employee_infos", "ecr_name":"satyam_project", "function_name":"satyam_lambda_function"}
}
