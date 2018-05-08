data "aws_ecr_repository" "hello_world_repo" {
  name = "${var.role}_${var.app}_${var.env}-${var.user}_hello-world"
}

data "aws_ecr_repository" "unzip_repo" {
  name = "${var.role}_${var.app}_${var.env}-${var.user}_unzip_save_to_s3"
}

output "container_repo_url" {
  value = "${data.aws_ecr_repository.hello_world_repo.repository_url}"
}

output "container_repo_url_unzip" {
  value = "${data.aws_ecr_repository.unzip_repo.repository_url}"
}
