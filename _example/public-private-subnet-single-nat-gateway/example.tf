provider "aws" {
  region = "ca-central-1"
}

##-----------------------------------------------------------------------------
## Vpc Module call.
##-----------------------------------------------------------------------------
module "vpc" {
  source                              = "git::https://github.com/chahalvikas2022/terraform-aws-vpc.git"
  name                                = "app"
  environment                         = "test"
  cidr_block                          = "10.0.0.0/16"
  enable_flow_log                     = true # Flow logs will be stored in cloudwatch log group. Variables passed in default.
  create_flow_log_cloudwatch_iam_role = true
  additional_cidr_block               = ["172.3.0.0/16", "172.2.0.0/16"]
  dhcp_options_domain_name            = "service.consul"
  dhcp_options_domain_name_servers    = ["127.0.0.1", "10.10.0.2"]
  assign_generated_ipv6_cidr_block    = true
}

##-----------------------------------------------------------------------------
## Subnet Module call.
##-----------------------------------------------------------------------------

module "subnets" {
  source              = "./../../"
  nat_gateway_enabled = true
  single_nat_gateway  = true
  name                = "app"
  environment         = "test"
  availability_zones  = ["ca-central-1a", "ca-central-1b", "ca-central-1d"]
  vpc_id              = module.vpc.id
  type                = "public-private"
  igw_id              = module.vpc.igw_id
  cidr_block          = module.vpc.vpc_cidr_block
  ipv6_cidr_block     = module.vpc.ipv6_cidr_block
  enable_ipv6         = false
}
