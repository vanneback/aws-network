output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "private_sn_id" {
  value = "${aws_subnet.private_sn.id}"
}

output "public_sn_id" {
  value = "${aws_subnet.public_sn.id}"
}

output "public_sg" {
  value = "${aws_security_group.public_sg.id}"
}

output "private_sg" {
  value = "${aws_security_group.private_sg.id}"
}

output "key_name" {
  value= "${aws_key_pair.default_key_pair.key_name}"
}
