
resource "aws_route_table" "private" {
  count = count(var.private_subnets)

  vpc_id = aws_vpc.this.id

  lifecycle {
    ignore_changes = [propagating_vgws]
  }

  tags = {
    Name = format("%s-private-%s", var.name, count.index)
  }
}

resource "aws_route" "private" {
  count = count(var.private_subnets)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private.id

  timeouts {
    create = "5m"
  }
}
