provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
}

data "aws_ami" "virus_aquarium_web" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Name"
    values = ["virus_aquarium_web"]
  }

  most_recent = true
}

module "virus_aquarium_web_hosts" {
  source                 = "../ec2"
  ami                    = "${data.aws_ami.virus_aquarium_web.id}"
  count                  = "${var.virus_aquarium_web_hosts_count}"
  subnet_id              = "${module.network.subnet_id}"
  vpc_security_group_ids = ["${module.network.sg_ssh_id}", "${module.network.sg_web_id}"]
  key_name               = "${var.ssh_key_name}"
}

module "network" {
  source = "../network"
}
