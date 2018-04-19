################################################
#            CONFIGURE REMOTE STATE            #
################################################

terraform {
  backend "s3"  {
    bucket  = "clarivate-wos-dev-terraform-state"
    key     = "env:/global/dev/batch_job_example/global/terraform.tfstate"
    region  = "us-east-1"
    profile = "wos-dev"
  }
}

