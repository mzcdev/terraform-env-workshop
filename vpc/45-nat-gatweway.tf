
resource "aws_eip" "private" {
  vpc = true

  depends_on = [aws_route_table.public]

  tags = merge(
    {
      Name = format(
        "%s-private-%s",
        var.name,
        element(split("", var.public_subnets[0].zone), length(var.public_subnets[0].zone) - 1)
      )
    },
    var.tags,
  )
}

resource "aws_nat_gateway" "private" {
  allocation_id = aws_eip.private.id

  subnet_id = aws_subnet.public[0].id

  tags = merge(
    {
      Name = format(
        "%s-private-%s",
        var.name,
        element(split("", var.public_subnets[0].zone), length(var.public_subnets[0].zone) - 1)
      )
    },
    var.tags,
  )
}
