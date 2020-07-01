# backend

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-seoul"
    key            = "eks-demo-charts.tfstate"
    dynamodb_table = "terraform-workshop-seoul"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

# terraform {
#   backend "remote" {
#     organization = "workshop"
#     workspaces {
#       name = "dev-eks-demo-charts"
#     }
#   }
# }

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "terraform-workshop-seoul"
    key    = "eks-demo.tfstate"
  }
}

# data "terraform_remote_state" "eks" {
#   backend = "remote"
#   config = {
#     organization = "workshop"
#     workspaces = {
#       name = "dev-eks-demo"
#     }
#   }
# }
