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
  dhcp_options_domain_name            = "service.consul"
  dhcp_options_domain_name_servers    = ["127.0.0.1", "10.10.0.2"]
  assign_generated_ipv6_cidr_block    = true
}

##-----------------------------------------------------------------------------
## Subnet Module call.
##-----------------------------------------------------------------------------

module "subnet" {
  source             = "./../.."
  name               = "app"
  environment        = "test"
  availability_zones = ["ca-central-1a", "ca-central-1b", "ca-central-1d"]
  vpc_id             = module.vpc.id
  type               = "public"
  igw_id             = module.vpc.igw_id
  ipv4_public_cidrs  = ["10.0.1.0/24", "10.0.13.0/24", "10.0.18.0/24"]
  enable_ipv6        = false
}
