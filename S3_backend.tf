terraform {
  backend "s3" {
    # bucket = "satyam-terra-backend-1"
    # key    = "terraform.tfstate"
    bucket = var.bucket_name
    key    = var.key_name
    region = "ap-south-1"
    profile = "satyam"
  }
}



variable "bucket_name" {}

variable "key_name" {}

