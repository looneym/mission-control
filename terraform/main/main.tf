provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
}

terraform {
  backend "s3" {}
}

module "ec2" {
  source = "../ec2"
  count = "${var.ec2_instance_count}"
  subnet_id = "${module.network.subnet_id}"
  vpc_security_group_ids = ["${module.network.sg_ssh_id}","${module.network.sg_web_id}"]
  key_name = "${var.ssh_key_name}"
}

module "network" {
  source = "../network"
}
