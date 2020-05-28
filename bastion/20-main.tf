# bastion

module "bastion" {
  source = "github.com/mzcdev/terraform-aws-bastion?ref=v0.12.15"

  name = var.name

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]

  administrator = var.administrator

  allow_ip_address = var.allow_ip_address

  user_data = data.template_file.setup.rendered

  key_name = var.key_name
}
