
resource "aws_route_table" "public" {
  count = length(var.public_subnets)

  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = format(
        "%s-public-%s",
        var.name,
        element(split("", var.public_subnets[count.index].zone), length(var.public_subnets[count.index].zone) - 1)
      )
    },
    var.tags,
  )
}

resource "aws_route" "public" {
  count = length(var.public_subnets)

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  timeouts {
    create = "5m"
  }
}
