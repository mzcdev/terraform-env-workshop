
resource "aws_eip" "private" {
  vpc = true

  depends_on = [aws_route_table.public]

  tags = {
    Name = format("%s-private", var.name)
  }
}

resource "aws_nat_gateway" "private" {
  allocation_id = aws_eip.private.id

  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = format("%s-private", var.name)
  }
}
