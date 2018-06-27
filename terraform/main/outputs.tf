output "key_file_with_path" {
  value = "${module.key_pair.key_file_with_path}"
}

output "web_instance_public_ips" {
  value = "${module.ec2.web_instance_public_ips}"
}

