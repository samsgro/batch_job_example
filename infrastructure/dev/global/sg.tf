###########################################################################################
#   USING TERRAFORM MODULE REGISTRY FOR SG                                                #
#   https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/1.9.0  #
#                                                                                         #
#   INBOUND RULE: SSH BATCH INSTANCES THROUGH BASTION                                     #
#   OUTBOUND RULE: ALL TRAFFIC ALLOWED                                                    #
###########################################################################################

module "batch-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "1.9.0"
  name    = "${var.role}_${var.app}_${var.region}_${var.env}-${var.user}"
  vpc_id  = "${data.aws_vpc.vpc.id}"
  tags    = "${module.tags.tags_merged}"

  ingress_with_source_security_group_id = [
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "SSH access through bastion"
      source_security_group_id = "${data.aws_security_group.infra_bastion.id}"
    },
  ]

  egress_with_cidr_blocks = [
    {
      rule = "all-all"
      description = "Allow outgoing"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

data "aws_security_group" "infra_bastion" {
  name = "infra_bastion"
}
