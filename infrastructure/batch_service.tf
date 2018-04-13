variable app   { }

resource "aws_batch_compute_environment" "batch_service" {
 compute_environment_name = "batch_service-${var.app}-${var.user}"
 compute_resources {
   instance_role = "${aws_iam_instance_profile.instance_role.arn}"
   instance_type = [
     "m3"
   ]
   max_vcpus          = 3
   min_vcpus          = 1
   desired_vcpus      = 1
   security_group_ids = [
     "${aws_security_group.infra_batch.id}"
   ]
   subnets = ["${data.aws_subnet_ids.private.ids}"]
   type    = "EC2"
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

