# backend

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-seoul"
    key            = "vpc-demo.tfstate"
    dynamodb_table = "terraform-workshop-seoul"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

# terraform {
#   backend "remote" {
#     organization = "workshop"
#     workspaces {
#       name = "dev-vpc-demo"
#     }
#   }
# }
