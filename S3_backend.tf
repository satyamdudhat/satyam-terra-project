terraform {
  backend "s3" {
    bucket = "satyam-terra-backend"
    key    = "terraform.tfstate"
    region = "us-west-2"
    profile = "sandbox"
  }
}
