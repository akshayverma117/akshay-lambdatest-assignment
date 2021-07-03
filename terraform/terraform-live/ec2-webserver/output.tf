output "id" {
  description = "List of IDs of instances"
  value       = module.webserver.id
}

output "arn" {
  description = "List of ARNs of instances"
  value       = module.webserver.arn
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = module.webserver.availability_zone
}

output "placement_group" {
  description = "List of placement groups of instances"
  value       = module.webserver.placement_group
}

output "key_name" {
  description = "List of key names of instances"
  value       = module.webserver.key_name
}

output "password_data" {
  description = "List of Base-64 encoded encrypted password data for the instance"
  value       = module.webserver.password_data
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = module.webserver.public_dns
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.webserver.public_ip
}

output "ipv6_addresses" {
  description = "List of assigned IPv6 addresses of instances"
  value       = module.webserver.ipv6_addresses
}

output "primary_network_interface_id" {
  description = "List of IDs of the primary network interface of instances"
  value       = module.webserver.primary_network_interface_id
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = module.webserver.private_dns
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = module.webserver.private_ip
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = module.webserver.security_groups
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = module.webserver.vpc_security_group_ids
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = module.webserver.subnet_id
}

output "credit_specification" {
  description = "List of credit specification of instances"
  value       = module.webserver.credit_specification
}

# output "metadata_options" {
#   description = "List of metadata options of instances"
#   value       = module.webserver.metadata_options
# }

output "instance_state" {
  description = "List of instance states of instances"
  value       = module.webserver.instance_state
}

output "root_block_device_volume_ids" {
  description = "List of volume IDs of root block devices of instances"
  value       = module.webserver.root_block_device_volume_ids
}

output "ebs_block_device_volume_ids" {
  description = "List of volume IDs of EBS block devices of instances"
  value       = module.webserver.ebs_block_device_volume_ids
}

output "tags" {
  description = "List of tags of instances"
  value       = module.webserver.tags
}

output "volume_tags" {
  description = "List of tags of volumes of instances"
  value       = module.webserver.volume_tags
}

output "instance_count" {
  description = "Number of instances to launch specified as argument to this module"
  value       = module.webserver.instance_count
}
