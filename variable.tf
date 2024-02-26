variable "accountId" {
  type = string
}


variable "profile" {
  type = string
}


variable "myregion" {
  type = string
  default = "us-west-2"
}

variable "ecr_name" {
  type = string
}

variable "table_name" {
  type = string
}


variable "api_name" {
  type = string
}



# Api Gateway Resource name
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