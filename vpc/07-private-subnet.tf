
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.this.id

  availability_zone = var.private_subnets[count.index].zone

  cidr_block = var.private_subnets[count.index].cidr

  tags = {
    Name = format("%s-private-%s", var.name, count.index)
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
