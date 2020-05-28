# remote

# terraform {
#   backend "s3" {
#     region         = "ap-northeast-2"
#     bucket         = "terraform-mz-demo-seoul"
#     key            = "eks-demo-charts.tfstate"
#     dynamodb_table = "terraform-mz-demo-seoul"
#     encrypt        = true
#   }
#   required_version = ">= 0.12"
# }

terraform {
  backend "remote" {
    organization = "mzcdev"
    workspaces {
      name = "dev-eks-demo-charts"
    }
  }
}

# data "terraform_remote_state" "eks" {
#   backend = "s3"
#   config = {
#     region = "ap-northeast-2"
#     bucket = "terraform-mz-demo-seoul"
#     key    = "eks-demo.tfstate"
#   }
# }

data "terraform_remote_state" "eks" {
  backend = "remote"
  config = {
    organization = "mzcdev"
    workspaces = {
      name = "dev-eks-demo"
    }
  }
}
