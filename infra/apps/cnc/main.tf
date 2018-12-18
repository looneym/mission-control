module "hosts" {
  source                 = "../../modules/ec2"
  ami                    = "${var.ami}"
  count                  = "${var.count}"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  key_name               = "${var.ssh_key_name}"
  instance_type          = "t2.small"
}
