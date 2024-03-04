# Account All Details
variable "accountId" {
  type = string
}


variable "profile" {
  type = string
}


variable "myregion" {
  type = string
  default = "ap-south-1"
}

variable "ecr_name" {
  type = string
}









# DynamoDB Table Name
variable "table_name" {
  type = string
}





# Api Gateway Resource name
variable "api_name" {
  type = string
}

variable "endpoint_path" {
  type = string
  default = "status"
}

variable "endpoint_path_employee" {
  type = string
  default = "employee"
}


variable "endpoint_path_employees" {
  type = string
  default = "employees"
}