# output

output "id" {
  value = module.bastion.id
}

output "key_name" {
  value = module.bastion.key_name
}

output "private_ip" {
  value = module.bastion.private_ip
}

output "public_ip" {
  value = module.bastion.public_ip
}

output "security_group_id" {
  value = module.bastion.security_group_id
}
