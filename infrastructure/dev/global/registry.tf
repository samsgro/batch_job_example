###################################################################
#         Create a registry for a test docker container           #
###################################################################


resource "aws_ecr_repository" "wos_dev_repository"{
  name = "${var.role}_${var.app}_${var.env}-${var.user}_hello-world"
}

resource "aws_ecr_repository" "unzip_save_to_s3" {
  name = "${var.role}_${var.app}_${var.env}-${var.user}_unzip_save_to_s3"
}

output "ecr_hello_arn" {
  value = "${aws_ecr_repository.wos_dev_repository.arn}"
}
output "ecr_unzip_name"{
  value = "${aws_ecr_repository.unzip_save_to_s3.name}"
}

output "ecr_unzip_arn"{
  value = "${aws_ecr_repository.unzip_save_to_s3.arn}"
}
output "ecr_unzip_registry_id"{
  value = "${aws_ecr_repository.unzip_save_to_s3.registry_id}"
}

output "ecr_unzip_repository_url"{
  value = "${aws_ecr_repository.unzip_save_to_s3.repository_url}"
}

