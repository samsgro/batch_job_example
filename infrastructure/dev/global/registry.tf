###################################################################
#         Create a registry for a test docker container           #
###################################################################


resource "aws_ecr_repository" "wos_dev_repository"{
  name = "${var.role}_${var.app}_${var.env}-${var.user}_hello-world"
}

output "ecr_arn" {
  value = "${aws_ecr_repository.wos_dev_repository.arn}"
}
