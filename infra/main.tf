provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
}

data "aws_ami" "docker" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Name"
    values = ["docker"]
  }

  most_recent = true
}

module "network" {
  source = "../network"
}

module "web_01" {
  source                 = "./ec2"
  ami                    = "${data.aws_ami.docker.id}"
  count                  = "${var.web_01_hosts_count}"
  subnet_id              = "${module.network.subnet_id}"
  vpc_security_group_ids = ["${module.network.sg_ssh_id}", "${module.network.sg_web_id}"]
  key_name               = "${var.ssh_key_name}"
  instance_type          = "t2.small"
}

module "web_02" {
  source                 = "./ec2"
  ami                    = "${data.aws_ami.docker.id}"
  count                  = "${var.web_02_hosts_count}"
  subnet_id              = "${module.network.subnet_id}"
  vpc_security_group_ids = ["${module.network.sg_ssh_id}", "${module.network.sg_web_id}"]
  key_name               = "${var.ssh_key_name}"
  instance_type          = "t2.small"
}

data "template_file" "ansible_inventory_template" {
  template = "${file("${path.module}/templates/ansible_inventory")}"
  depends_on = [
    "module.web_01",
    "module.web_02",
  ]
  vars {
   web_01 = "${join("\n", module.web_01.instance_public_ips)}"
   web_02 = "${join("\n", module.web_02.instance_public_ips)}"
  }
}

resource "null_resource" "ansible_inventory" {
  triggers {
    template_rendered = "${data.template_file.ansible_inventory_template.rendered}"
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.ansible_inventory_template.rendered}' > ansible_inventory.cfg"
  }
}
