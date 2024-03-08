resource "aws_dynamodb_table" "employee_infos" {
  name           = var.table_name
  hash_key       = "employeeid"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "employeeid"
    type = "S"
  }
}