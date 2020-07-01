# backend

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-seoul"
    key            = "lambda-demo.tfstate"
    dynamodb_table = "terraform-workshop-seoul"
    encrypt        = true
  }
}

# terraform {
#   backend "remote" {
#     organization = "mzcdev"
#     workspaces {
#       name = "dev-lambda-demo"
#     }
#   }
# }
