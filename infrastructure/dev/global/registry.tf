
resource "aws_ecr_repository" "wos_dev_repository"{
  name = "hello-world-dev"
}

output "ecr_arn" {
  value = "${aws_ecr_repository.wos_dev_repository.arn}"
}
