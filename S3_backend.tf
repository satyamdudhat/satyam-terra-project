terraform {
  backend "s3" {
    # bucket = "satyam-terra-backend-1"
    # key    = "terraform.tfstate"
    bucket = var.buckets_name
    key    = var.key_path
    region = "ap-south-1"
    profile = "satyam"
  }
}





