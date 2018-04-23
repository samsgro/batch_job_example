##################################################
#     CONFIGURING AWS ENVIRONMENT ACCOUNT        #
##################################################

provider "aws" {
  region    = "${var.region}"
  profile   = "wos-${var.env}"
}

