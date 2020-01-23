
terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-seoul"
    key            = "bastion.tfstate"
    dynamodb_table = "terraform-workshop-seoul"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}
