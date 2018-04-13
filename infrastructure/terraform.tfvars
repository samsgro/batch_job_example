########################################## 
#                VARIABLES               # 
########################################## 

region                         = "us-west-2"
env                            = "dev"
app                            = "wos"
aws_wos_dev                    = "078897461510"
aws_wos_prod                   = "996733901146"
snapshots_prefix               = "/artifacts/snapshots/"
bucket_policy_tmpl             = "template_files/shared_bucket_policy.tmpl"
ecs_instance_policy_tmpl       = "template_files/ecs_instance_policy.tmpl"
s3_readonly_access_policy_tmpl = "template_files/s3_readonly_access_policy.tmpl"
batch_service_policy_tmpl      = "template_files/batch_service_policy.tmpl"
vpc_name                       = "clarivate-wos-main"
