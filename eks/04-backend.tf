# backend

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-147748575754"
    key            = "eks-demo.tfstate"
    dynamodb_table = "terraform-workshop-147748575754"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

# terraform {
#   backend "remote" {
#     organization = "workshop"
#     workspaces {
#       name = "dev-eks-demo"
#     }
#   }
# }

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "terraform-workshop-147748575754"
    key    = "vpc-demo.tfstate"
  }
}

# data "terraform_remote_state" "vpc" {
#   backend = "remote"
#   config = {
#     organization = "workshop"
#     workspaces = {
#       name = "dev-vpc-demo"
#     }
#   }
# }
