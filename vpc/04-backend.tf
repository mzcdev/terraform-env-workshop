# backend

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-mzcdev"
    key            = "vpc-demo.tfstate"
    dynamodb_table = "terraform-workshop-mzcdev"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

# terraform {
#   backend "remote" {
#     organization = "mzcdev"
#     workspaces {
#       name = "dev-vpc-demo"
#     }
#   }
# }
