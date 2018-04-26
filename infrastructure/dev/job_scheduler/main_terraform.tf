# -------------------------------------------------
#       CREATING POLICIES AND ROLES FOR
#                 LAMBDA f(x)
# -------------------------------------------------

# File that contains the policy for Lambda to access S3 resources

resource "template_file" "lambda_policy" {
    template = "${file("${var.lambda_role_policy_tmpl}")}"
    vars {
        source_bucket_name = "${var.bucket}${var.snapshots_key}${var.job_input}"
        target_bucket_name = "${var.bucket}${var.snapshots_key}${var.job_output}"
    }
}

module "iam_lambda" {
   source = "../modules/iam"

   app_name    = "${var.application-name}"
   policy_file = "${template_file.lambda_policy.rendered}"

}

# ------------------------------------------------
#              CREATES LAMBDA f(X)
# ------------------------------------------------

module "lambda_function" {
  source = "./modules/lambda"

  zip_file      = "${var.lambda_function_zip_file}"
  app-name      = "${var.application-name}"
  role          = "${module.iam_lambda.execution_role_arn}"
  handler       = "main.handle"
  runtime       = "python2.7"

  source_arn    = "${module.s3_buckets.source-bucket-arn}"
  source_id     = "${module.s3_buckets.source-bucket-id}"

  events        = "s3:ObjectCreated:*"
  filter_prefix = "${var.snapshots_key}${var.job_input}/"
  filter_suffix = "*"
}

output "lambda_function_arn" { value = "${module.lambda_function.lambda_function_arn}" }
output "exectution_role_arn" { value = "${module.iam_lambda.execution_role_arn}" }

