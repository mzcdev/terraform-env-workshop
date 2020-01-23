
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id = aws_vpc.this.id

  availability_zone = var.public_subnets[count.index].zone

  cidr_block = var.public_subnets[count.index].cidr

  tags = {
    Name = format("%s-public-%s", var.name, count.index)
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}
