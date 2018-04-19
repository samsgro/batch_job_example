#####################################################
#        CREATES THE ROLE NEEDED FOR ECS            #
#####################################################

variable user                            { }
variable ecs_instance_policy_tmpl        { }
variable s3_readonly_access_policy_tmpl  { }
variable batch_service_policy_tmpl       { }


// Role that will be assumed by instance managed by the batch service

resource "aws_iam_role" "batch_instance_role" {
  name = "batch_instance_role-${var.user}"
  path = "/cl/app/wosdataconv/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
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

// Policy with basic ECS execution permissions

data "template_file" "ECS_instance_policy_template" {
  template = "${ file( "${ var.ecs_instance_policy_tmpl }" )}"
}

// Policy for the instances to have correct permissions to access app services

data "template_file" "S3_readonly_access_policy_template" {
  template = "${ file( "${ var.s3_readonly_access_policy_tmpl }" )}"
}

resource "aws_iam_policy" "ECS_instance_policy" {
  name        = "ECSInstancePolicy-${var.user}"
  path        = "/cl/app/wosdataconv/"
  description = "Policy for ECS instances"
  
  policy      = "${data.template_file.ECS_instance_policy_template.rendered}"
}

resource "aws_iam_policy" "s3_readonly_policy" {
  name        = "S3ReadOnlyAccessPolicy-${var.user}"
  path        = "/cl/app/wosdataconv/"
  description = "Policy for s3 read only access"
  
  policy      = "${data.template_file.S3_readonly_access_policy_template.rendered}"
}

resource  "aws_iam_role_policy_attachment" "ECS_for_EC2" {
  role       = "${aws_iam_role.batch_instance_role.name}"
  policy_arn = "${aws_iam_policy.ECS_instance_policy.arn}"
}

resource  "aws_iam_role_policy_attachment" "ECS_S3_read_only" {
  role       = "${aws_iam_role.batch_instance_role.name}"
  policy_arn = "${aws_iam_policy.s3_readonly_policy.arn}"
}

// Execution role for the Batch Service

resource "aws_iam_instance_profile" "instance_role" {
 path = "/cl/app/wosdataconv/"
 name = "BatchInstanceProfileRole-${var.user}"
 role = "${aws_iam_role.batch_instance_role.name}"
}

data "template_file" "batch_service_policy_template"{
  template = "${ file( "${ var.batch_service_policy_tmpl}" )}"
}

resource "aws_iam_role" "aws_batch_service_role" {
 path = "/cl/app/wosdataconv/"
 name = "BatchServiceRole-${var.user}"
 assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
   {
       "Action": "sts:AssumeRole",
       "Effect": "Allow",
       "Principal": {
       "Service": "batch.amazonaws.com"
       }
   }
   ]
}
EOF
}

resource "aws_iam_policy" "batch_service_policy" {
  name        = "BatchServicePolicy-${var.user}"
  path        = "/cl/app/wosdataconv/"
  description = "Policy for s3 read only access"
  
  policy      = "${data.template_file.batch_service_policy_template.rendered}"
}

resource "aws_iam_role_policy_attachment" "aws_batch_service_role" {
 role       = "${aws_iam_role.aws_batch_service_role.name}"
 policy_arn = "${aws_iam_policy.batch_service_policy.arn}"
}

output "batch_instance_role_name" {
  value = "${aws_iam_role.batch_instance_role.name}"
}
output "batch_instance_role_arn" {
  value = "${aws_iam_role.batch_instance_role.arn}"
}
output "s3_readonly_policy" {
  value = "${aws_iam_policy.s3_readonly_policy.arn}"
}
output "batch_service_role_name" {
 value = "${aws_iam_role.aws_batch_service_role.name}"
}
output "batch_service_role_arn" {
  value = "${aws_iam_role.aws_batch_service_role.arn}"
}

