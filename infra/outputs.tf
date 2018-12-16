output "ssh_key_name" {
  value = "${var.ssh_key_name}"
}

output "web_instance_public_ips" {
  value = "${module.virus_aquarium_web_hosts.instance_public_ips}"
}
