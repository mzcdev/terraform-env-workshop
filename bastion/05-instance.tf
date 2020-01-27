
resource "aws_instance" "this" {
  ami           = var.ami_id != "" ? var.ami_id : data.aws_ami.this.id
  instance_type = var.instance_type
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  key_name      = var.key_name

  # user_data = var.user_data
  user_data = data.template_file.setup.rendered

  iam_instance_profile = aws_iam_instance_profile.this.id

  vpc_security_group_ids = [
    aws_security_group.this.id,
  ]

  tags = {
    Name = var.name
    Type = "bastion"
  }
}
