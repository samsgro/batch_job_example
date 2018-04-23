data "aws_ecr_repository" "hello_world_repo" {
  name = "${var.role}_${var.app}_${var.env}-${var.user}_hello-world"
}

output "container_repo_url" {
  value = "${data.aws_ecr_repository.hello_world_repo.repository_url}"
}
