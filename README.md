# 🏗️ Terraform-AWS-Subnet

[![OpsStation](https://img.shields.io/badge/Made%20by-OpsStation-blue?style=flat-square&logo=terraform)](https://www.opsstation.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.13%2B-purple.svg?logo=terraform)](#)
[![CI](https://github.com/OpsStation/terraform-aws-subnet/actions/workflows/ci.yml/badge.svg)](https://github.com/OpsStation/terraform-aws-subnet/actions/workflows/ci.yml)

> 🌩️ **A production-grade, reusable AWS Subnet module by [OpsStation](https://www.opsstation.com)**
> Designed for reliability, performance, and security — following AWS networking best practices.
---

## 🏢 About OpsStation

**OpsStation** delivers **Cloud & DevOps excellence** for modern teams:
- 🚀 **Infrastructure Automation** with Terraform, Ansible & Kubernetes
- 💰 **Cost Optimization** via scaling & right-sizing
- 🛡️ **Security & Compliance** baked into CI/CD pipelines
- ⚙️ **Fully Managed Operations** across AWS, Azure, and GCP

> 💡 Need enterprise-grade DevOps automation?
> 👉 Visit [**www.opsstation.com**](https://www.opsstation.com) or email **hello@opsstation.com**

---

## 🌟 Features

- ✅ Creates **Public**, **Private**, and **Database** subnets
- ✅ Supports **multiple Availability Zones** and **custom CIDR blocks**
- ✅ Automatic **route table association** for each subnet type
- ✅ Optional **NAT Gateway** support for private subnets
- ✅ Compatible with **VPC Flow Logs** for enhanced network visibility
- ✅ Tags and naming convention managed through the **Labels module**
- ✅ Seamless integration with other OpsStation Terraform modules

---


## ⚙️ Usage Example
# Example: private-subnet

```hcl
module "private-subnets" {
  source              = "git::https://github.com/opsstation/terraform-aws-subnet.git?ref=v1.0.0"
  name                = "app"
  environment         = "test"
  nat_gateway_enabled = true
  availability_zones  = ["eu-west-1a"]
  vpc_id              = module.vpc.vpc_id
  type                = "private"
  cidr_block          = module.vpc.vpc_cidr_block
  ipv6_cidr_block     = module.vpc.ipv6_cidr_block
  ipv4_private_cidrs  = ["10.0.3.0/24"]
  public_subnet_ids   = ["subnet-07962e9e61ad3bcd3"]
}
```

# Example: public-private-subnet-single-nat-gateway

```hcl
module "subnets" {
  source              = "./../../"
  nat_gateway_enabled = true
  single_nat_gateway  = true
  name                = "app"
  environment         = "test"
  availability_zones  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  vpc_id              = module.vpc.vpc_id
  type                = "public-private"
  igw_id              = module.vpc.igw_id
  cidr_block          = module.vpc.vpc_cidr_block
  ipv6_cidr_block     = module.vpc.ipv6_cidr_block
  enable_ipv6         = false
}
```

# Example: public-private

```hcl
module "subnets" {
  source                                         = "./../../"
  name                                           = "app"
  environment                                    = "test"
  nat_gateway_enabled                            = true
  availability_zones                             = ["eu-west-1a", "eu-west-1b"]
  vpc_id                                         = module.vpc.vpc_id
  type                                           = "public-private"
  igw_id                                         = module.vpc.igw_id
  cidr_block                                     = module.vpc.vpc_cidr_block
  ipv6_cidr_block                                = module.vpc.ipv6_cidr_block
  public_subnet_assign_ipv6_address_on_creation  = true
  enable_ipv6                                    = true
  private_subnet_assign_ipv6_address_on_creation = true
}
```

# Example: public-subnet

```hcl
module "subnet" {
  source             = "./../.."
  name               = "app"
  environment        = "test"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_id             = module.vpc.vpc_id
  type               = "public"
  igw_id             = module.vpc.igw_id
  ipv4_public_cidrs  = ["10.0.1.0/24", "10.0.13.0/24", "10.0.18.0/24"]
  enable_ipv6        = false
}
```


### ☁️ Outputs (AWS Subnet Module)

| Name                        | Description                                                        |
|-----------------------------|--------------------------------------------------------------------|
| `public_subnet_ids`         | The IDs of the created **Public Subnets**.                          |
| `private_subnet_ids`        | The IDs of the created **Private Subnets**.                         |
| `database_subnet_ids`       | The IDs of the created **Database Subnets**.                        |
| `public_route_table_ids`    | The IDs of the Route Tables associated with **Public Subnets**.     |
| `private_route_table_ids`   | The IDs of the Route Tables associated with **Private Subnets**.    |
| `database_route_table_ids`  | The IDs of the Route Tables associated with **Database Subnets**.   |
| `public_subnet_arns`        | The ARNs of the created **Public Subnets**.                         |
| `private_subnet_arns`       | The ARNs of the created **Private Subnets**.                        |
| `database_subnet_arns`      | The ARNs of the created **Database Subnets**.                       |
| `availability_zones`        | The list of Availability Zones used to create the subnets.          |
| `tags`                      | A mapping of tags assigned to the subnet resources.                |

### ☁️ Tag Normalization Rules (AWS)

| Cloud | Case      | Allowed Characters | Example                            |
|--------|-----------|------------------|------------------------------------|
| **AWS** | TitleCase | Any              | `Name`, `Environment`, `CostCenter` |

---

### 💙 Maintained by [OpsStation](https://www.opsstation.com)
> OpsStation — Simplifying Cloud, Securing Scale.
