
variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
  type        = string
  default     = "us-east-1"
}

variable "domain" {
  description = "The Hosted Zone name of the desired Hosted Zone."
  type        = string
  default     = "mzdev.be"
}
