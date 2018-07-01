provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
}

terraform {
  backend "s3" {}
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

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

module "testbench" {
  source                 = "../ec2"
  ami                    = "${data.aws_ami.ubuntu.id}"
  count                  = 1
  subnet_id              = "${module.network.subnet_id}"
  vpc_security_group_ids = ["${module.network.sg_ssh_id}", "${module.network.sg_web_id}"]
  key_name               = "${var.ssh_key_name}"
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
