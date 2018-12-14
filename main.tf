provider "aws" {
  region = "${var.region}"
}

module "network" {
  source    = "./network"
  vpc_cidr  = "${var.vpc_cidr}"
  AZ        = "${var.AZ}"
  project   = "${var.project}"
}

module "instance" {
  source        = "./instances"
  private_sn_id = "${module.network.private_sn_id}"
  public_sn_id  = "${module.network.public_sn_id}"
  public_sg     = "${module.network.public_sg}"
  private_sg    = "${module.network.private_sg}"
  key_name      = "${module.network.key_name}"

  AZ            = "${var.AZ}"
  project       = "${var.project}"
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  
}
