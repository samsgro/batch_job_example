# ----------------------------------------
#            LAMBDA VARIABLES
# ----------------------------------------

//Account related vars

aws-region       = "us-west-2"
aws_wos_dev      = "078897461510"
aws_wos_prod     = "996733901146"
vpc_name         = "clarivate-wos-main"

// Tags related vars
application-name = "batch_scheduler_lambda"
env              = "dev"
role             = "batch_service"

// S3 information
bucket                       = "clarivate.wos.dev.us-west-2.build-tools"
snapshots_key                = "artifacts/snapshots/"
job_input                    = "job_input"
job_output                   = "job_output"

// Lambda policy template location
lambda_role_policy_tmpl      = "template_files/lambda_policy_s3_resources.tmpl"
lambda_batch_policy_tmpl     = "template_files/lambda_policy_batch_access.tmpl" 
lambda_execution_policy_tmpl = "template_files/lambda_execution_policy.tmpl"

// Lambda code zip file
lambda_function_zip_file     = "../../../function/batch_job_scheduler.zip"

