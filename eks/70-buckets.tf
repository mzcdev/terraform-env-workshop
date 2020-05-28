# buckets

resource "aws_s3_bucket" "this" {
  count = length(var.buckets)

  bucket = var.buckets[count.index]

  acl = "private"

  force_destroy = true

  tags = {
    "Name"                                = var.buckets[count.index]
    "KubernetesCluster"                   = local.name
    "kubernetes.io/cluster/${local.name}" = "owned"
  }
}

output "bucket_names" {
  value = aws_s3_bucket.this.*.bucket
}
