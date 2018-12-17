output "ssh_key_name" {
  value = "${var.ssh_key_name}"
}

output "web_01_public_ips" {
  value = "${module.web_01.instance_public_ips}"
}

output "web_02_public_ips" {
  value = "${module.web_02.instance_public_ips}"
}
