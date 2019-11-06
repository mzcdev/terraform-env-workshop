# vpc

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-seoul"
    key            = "lambda.tfstate"
    dynamodb_table = "terraform-workshop-seoul"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

module "lambda" {
  source = "github.com/nalbam/terraform-aws-lambda-api?ref=v0.12.2"
  region = var.region

  name        = var.name
  stage       = var.stage
  description = "api > lambda > demo"
  runtime     = "nodejs10.x"
  handler     = "index.handler"
  memory_size = 512
  timeout     = 5

  s3_bucket = var.s3_bucket
  s3_source = "lambda.zip"
  s3_key    = "lambda/${var.stage}-${var.name}-${random_pet.deploy.id}.zip"

  env_vars = {
    PROFILE = var.stage
  }
}

resource "random_pet" "deploy" {
}
