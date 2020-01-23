
resource "aws_route_table" "public" {
  count = count(var.public_subnets)

  vpc_id = aws_vpc.this.id

  tags = {
    Name = format("%s-public-%s", var.name, count.index)
  }
}

resource "aws_route" "public" {
  count = count(var.public_subnets)

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  timeouts {
    create = "5m"
  }
}
