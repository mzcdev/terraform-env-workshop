
resource "aws_instance" "this" {
  ami           = var.ami_id != "" ? var.ami_id : data.aws_ami.this.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  user_data     = var.user_data
  key_name      = var.key_name

  iam_instance_profile = aws_iam_instance_profile.this.id

  vpc_security_group_ids = [
    aws_security_group.this.id,
  ]

  tags = {
    Name = var.name
    Type = "bastion"
  }
}
