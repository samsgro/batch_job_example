data "aws_security_group" "batch_sg" {
  name   = "${var.role}_${var.app}_${var.region}_${var.env}-${var.user}"
  vpc_id = "${data.aws_vpc.vpc.id}"
}

output "batch_sg" {
  value = "${data.aws_security_group.batch_sg.id}"
}
