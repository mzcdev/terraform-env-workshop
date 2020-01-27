
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "terraform-workshop-seoul"
    key    = "vpc-demo.tfstate"
  }
}

data "aws_ami" "this" {
  most_recent = true

  owners = ["137112412989"] # AWS's account ID.

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
}

data "template_file" "setup" {
  template = file("templates/setup.sh")

  vars = {
    HOSTNAME = var.name
  }
}
