resource "aws_instance" "frontend" {
  ami                   = "${var.ami}"
  instance_type         = "${var.instance_type}"
  subnet_id             = "${var.public_sn_id}"
  associate_public_ip_address = true

  availability_zone     = "${var.AZ}"
  vpc_security_group_ids = ["${var.public_sg}"]
  key_name              = "${var.key_name}"
  #iam_instance_profile =
  
  tags {
    Name                = "${var.project}-frontend"
    Project             = "${var.project}"
  }
}

resource "aws_instance" "backend" {
  ami                   = "${var.ami}"
  instance_type         = "${var.instance_type}"
  subnet_id             = "${var.private_sn_id}"
  associate_public_ip_address = false

  availability_zone     = "${var.AZ}"
  vpc_security_group_ids = ["${var.private_sg}"]
  key_name              = "${var.key_name}"
  #iam_instance_profile =
  
  tags {
    Name                = "${var.project}-backend"
    Project             = "${var.project}"
  }
}
