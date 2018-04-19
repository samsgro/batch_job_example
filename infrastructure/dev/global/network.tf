// 

variable vpc_name    { }

data "aws_vpc" "vpc" {
filter {
   name   = "tag:Name"
   values = ["${var.vpc_name}"]
 }
}

data "aws_subnet_ids" "private" {
 vpc_id = "${data.aws_vpc.vpc.id}"

 tags {
   Name = "${var.vpc_name}.internal.us-west-2*"
 }
}

output "subnet_ids" {
  value = "${data.aws_subnet_ids.private.ids}"
}
output "vpc_id" {
  value = "${data.aws_vpc.vpc.id}"
}
