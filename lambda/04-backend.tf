# backend

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-mzcdev"
    key            = "lambda-demo.tfstate"
    dynamodb_table = "terraform-workshop-mzcdev"
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
