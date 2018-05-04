##################################################
#     CONFIGURING AWS ENVIRONMENT ACCOUNT        #
##################################################

provider "aws" {
  region    = "${var.aws-region}"
  profile   = "wos-${var.env}"
}

