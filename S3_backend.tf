terraform {
  backend "s3" {
    # bucket = "satyam-terra-backend-1"
    # key    = "terraform.tfstate"
    bucket = locals.buckets_name
    key    = locals.key_path
    region = "ap-south-1"
    profile = "satyam"
  }
}

locals {
  buckets_name = get_env("TF_VAR_buckets_name")
  key_path = get_env("TF_var_key_path")
}



