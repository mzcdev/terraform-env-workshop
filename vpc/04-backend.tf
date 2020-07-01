# backend

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-147748575754"
    key            = "vpc-demo.tfstate"
    dynamodb_table = "terraform-workshop-147748575754"
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
