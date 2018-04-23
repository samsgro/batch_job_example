data "aws_iam_instance_profile" "instance_profile" {
  name = "${var.role}_${var.app}_${var.env}-${var.user}_BatchInstanceProfileRole"
}
data "aws_iam_role" "instance_role" {
  name = "${var.role}_${var.app}_${var.env}-${var.user}_InstanceRole"
}

data "aws_iam_role" "batch_service_role" {
  name = "${var.role}_${var.app}_${var.env}-${var.user}_ExecutionRole"
}

output "instance_role_arn" {
  value = "${data.aws_iam_role.instance_role.arn}"
}

output "batch_service_role_arn"{
  value = "${data.aws_iam_role.batch_service_role.arn}"
}

output "instance_profile_arn" {
  value = "${data.aws_iam_instance_profile.instance_profile.arn}"
}
