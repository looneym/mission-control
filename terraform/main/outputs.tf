output "ssh_key_name" {
  value = "${var.ssh_key_name}"
}

output "web_instance_public_ips" {
  value = "${module.ec2.web_instance_public_ips}"
}

