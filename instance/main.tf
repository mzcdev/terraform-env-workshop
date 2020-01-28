
resource "aws_instance" "this" {
  ami           = "ami-0bea7fd38fabe821a"
  instance_type = "t2.micro"

  tags = {
    Name = var.name
  }
}

output "id" {
  value = aws_instance.this.id
}
