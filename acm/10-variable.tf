
variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
  type        = string
  default     = "us-east-1"
}

variable "domain_root" {
  description = ""
  type        = string
  default     = "mzdev.be"
}

variable "domain_name" {
  description = ""
  type        = string
  default     = "demo-api-workshop.mzdev.be"
}
