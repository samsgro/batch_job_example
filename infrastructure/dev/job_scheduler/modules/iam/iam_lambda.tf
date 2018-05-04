# ------------------------------------------------
#       CREATING POLICIES AND ROLES FOR
#                 LAMBDA f(x)
# ------------------------------------------------

variable "app_name"                     { }
variable "role"                         { }
variable "env"                          { }
variable "user"                         { }

variable "policy_file"                  { }
variable "batch_policy_file"            { }
variable "execution_policy_file"        { }

# CREATING EXECUTION ROLE

resource "aws_iam_role" "exec_role" {
    name = "${var.role}_${var.app_name}_${var.env}-${var.user}_ExecutionRole"
    path = "/cl/app/wosdataconv/"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Execution Lambda policy, grants permissions to CloudWatch and S3

resource "aws_iam_policy" "lambda_exec_pol" {
    name        = "${var.role}_${var.app_name}_${var.env}-${var.user}_ExecutionPolicy"
    path        = "/cl/app/wosdataconv/"
    description = "Execution policy with full access to logs and put and get object in s3"
    policy      = "${var.execution_policy_file}"    
}

resource "aws_iam_role_policy_attachment" "lambda_execute" {
    role       = "${aws_iam_role.exec_role.name}"
    policy_arn = "${aws_iam_policy.lambda_exec_pol.arn}"
}

# S3 and ElasticSearch resources

resource "aws_iam_policy" "lambda_access_pol"{
    name         = "${var.role}_${var.app_name}_${var.env}-${var.user}_S3AccessPolicy"
    path         = "/cl/app/wosdataconv/"
    description  = "Permissions needed for the Lambda to run"
    policy       = "${var.policy_file}"
}

resource "aws_iam_role_policy_attachment" "lambda_access" {
    role         = "${aws_iam_role.exec_role.name}"
    policy_arn   = "${aws_iam_policy.lambda_access_pol.arn}"
}

#resource "aws_iam_role_policy" "lambda_policy" {
#    name = "${var.role}_${var.app_name}_${var.env}-${var.user}_access-resources-policy"
#    role = "${aws_iam_role.exec_role.id}"
#    policy = "${var.policy_file}"
#}

# Batch Full Access

resource "aws_iam_policy" "lambda_batch_access_pol" {
    name         = "${var.role}_${var.app_name}_${var.env}-${var.user}_BatchAccessPol"
    path         = "/cl/app/wosdataconv/"
    description  = "Permissions needed for Lambda to run"
    policy       = "${var.batch_policy_file}"
}

resource "aws_iam_role_policy_attachment" "lambda_batch_access" {
    role         = "${aws_iam_role.exec_role.name}"
    policy_arn   = "${aws_iam_policy.lambda_batch_access_pol.arn}"
}


output "execution_role_arn" { value = "${aws_iam_role.exec_role.arn}" }

output "exec_pol" { value = "${aws_iam_policy.lambda_exec_pol.arn}" }
