#####################################################
#        CREATES THE ROLE NEEDED FOR ECS            #
#####################################################

variable user      { }

resource "aws_iam_role" "batch_job_role" {
  name = "batch_ecs_role-${var.user}"
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
