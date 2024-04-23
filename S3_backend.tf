terraform {
  backend "s3" {
    bucket = "satyam-terra-backend-1"
    key    = "devs/terraform.tfstate"
    region = "ap-south-1"
    profile = "satyam"
  }
}
