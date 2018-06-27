provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
}


terraform {
  backend "s3" {}
}

module "key_pair" {
  source                = "../key-pair"
  name                  = "${var.key_pair_name}"
  should_generate_ssh_key      = "${var.should_generate_ssh_key}"
}

module "ec2" {
  source = "../ec2"
  subnet_id = "${module.network.subnet_id}"
  vpc_security_group_ids = ["${module.network.sg_ssh_id}","${module.network.sg_web_id}"]
  key_name = "${module.key_pair.key_name}"
}

module "network" {
  source = "../network"
}
