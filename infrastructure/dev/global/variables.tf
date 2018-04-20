##################################################
#    LIST OF VARIABLES USED IN OTHER TF FILES    #
##################################################

variable role    { }
variable app     { }
variable env     { default = "dev" }
variable user    { }

variable vpc_name     { }
variable region       { default = "us-west-2" }
variable aws_wos_dev  { }
variable aws_wos_prod { }

variable ecs_instance_policy_tmpl        { }
variable s3_readonly_access_policy_tmpl  { }
variable batch_service_policy_tmpl       { }

variable "default_tags" {
  type = "map"

  default = {
    "Name"                = "batch_service"
    "tr:appFamily"        = "batch_service_dev"
    "tr:appName"          = "wos"
    "tr:environment-type" = "dev"
    "tr:Role"             = "batch_service"
    "tr:created-by"       = "6047692"
  }
}
