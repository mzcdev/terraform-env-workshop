# backend

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-147748575754"
    key            = "lambda-demo.tfstate"
    dynamodb_table = "terraform-workshop-147748575754"
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
