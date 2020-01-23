
resource "aws_eip" "this" {
  instance = aws_instance.this.id

  vpc = true

  tags = {
    Name = var.name
  }
}
