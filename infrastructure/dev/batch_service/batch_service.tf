variable app   { }

resource "aws_batch_compute_environment" "batch_service" {
 compute_environment_name = "batch_service-${var.app}-${var.user}"
 compute_resources {
   ec2_key_pair  = "sar-devops-team"
   instance_role = "${aws_iam_instance_profile.instance_role.arn}"
   instance_type = [
     "m3"
   ]
   max_vcpus          = 3
   min_vcpus          = 1
   desired_vcpus      = 1
   security_group_ids = [
     "${module.batch-security-group.this_security_group_id}"
   ]
   subnets  = ["${data.aws_subnet_ids.private.ids}"]
   type     = "EC2"
   image_id = "ami-40ddb938"
 }
 service_role = "${aws_iam_role.aws_batch_service_role.arn}"
 type = "MANAGED"
 depends_on = ["aws_iam_role_policy_attachment.aws_batch_service_role"]
}

resource "aws_batch_job_queue" "batch_service_wos" {
 name = "batch-${var.app}-job-queue-${var.user}"
 state = "ENABLED"
 priority = 1
 compute_environments = ["${aws_batch_compute_environment.batch_service.arn}"]
}

resource "aws_batch_job_definition" "hello_world" {
   name = "batch_wos_job_definition"
   type = "container"
   container_properties = <<CONTAINER_PROPERTIES
{
   "command":["ls"],
   "image": "078897461510.dkr.ecr.us-west-2.amazonaws.com/hello-world-dev:latest",
   "memory": 512,
   "vcpus": 1
}
CONTAINER_PROPERTIES
}

