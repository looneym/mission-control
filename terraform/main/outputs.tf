output "ip" {
  value = "${module.ec2.public_ip}"
}

output "ssh_key_name" {
  value = "${var.ssh_key_name}"
}

