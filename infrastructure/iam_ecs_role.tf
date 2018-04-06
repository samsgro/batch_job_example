#####################################################
#        CREATES THE ROLE NEEDED FOR ECS            #
#####################################################

variable user      { }

resource "aws_iam_role" "batch_job_role" {
  name = "batch_ecs_role-${var.user}"
  path = "/cl/app/wosdataconv/"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource  "aws_iam_role_policy_attachment" "ECS_for_EC2" {
  role       = "${aws_iam_role.batch_job_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource  "aws_iam_role_policy_attachment" "ECS_S3_read_only" {
  role       = "${aws_iam_role.batch_job_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role-${var.user}"
  path = "/cl/app/wosdataconv/"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-task.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource  "aws_iam_role_policy_attachment" "ECS_exec" {
  role       = "${aws_iam_role.ecs_execution_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


output "ecs_exec_role_name" {
  value = "${aws_iam_role.ecs_execution_role.name}"
}
output "ecs_exec_role_arn" {
  value = "${aws_iam_role.ecs_execution_role.arn}"
}
output "batch_job_role_name" {
  value = "${aws_iam_role.batch_job_role.name}"
}
output "batch_job_role_arn" {
  value = "${aws_iam_role.batch_job_role.arn}"
}
