
resource "aws_route_table" "private" {
  count = length(var.private_subnets)

  vpc_id = aws_vpc.this.id

  lifecycle {
    ignore_changes = [propagating_vgws]
  }

  tags = merge(
    {
      Name = format(
        "%s-private-%s",
        var.name,
        element(split("", var.private_subnets[count.index].zone), length(var.private_subnets[count.index].zone) - 1)
      )
    },
    var.tags,
  )
}

resource "aws_route" "private" {
  count = length(var.private_subnets)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private.id

  timeouts {
    create = "5m"
  }
}
