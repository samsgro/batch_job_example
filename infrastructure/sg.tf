resource "aws_security_group" "infra_batch" {
  name        = "infra_batch-${var.user}"
  description = "security group for batch service"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    security_groups = [
      "${data.aws_security_group.infra_bastion.id}",
    ]
  }

  egress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

data "aws_security_group" "infra_bastion" {
  name = "infra_bastion"
}
