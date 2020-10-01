provider "aws" {
  region = var.region
}

module "vpc" {
  source = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.17.0"

  cidr_block = var.vpc_cidr_block

  context = module.this.context
}

module "subnets" {
  source = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.30.0"

  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = false
  nat_instance_enabled = false

  context = module.this.context
}


module "redis" {
  source                = "modules/redis/"
  name                  = "var.name"
  number_cache_clusters = "var.number_cache_clusters"
  node_type             = "var.node_type"

  engine_version             = "var.engine_version"
  port                       = "var.port"
  maintenance_window         = "var.maintenance_window"
  snapshot_window            = "var.snapshot_window"
  snapshot_retention_limit   = "var.snapshot_retention_limit"
  automatic_failover_enabled = "var.automatic_failover_enabled"
  at_rest_encryption_enabled = "var.at_rest_encryption_enabled"
  transit_encryption_enabled = "var.transit_encryption_enabled"
  apply_immediately          = "var.apply_immediately"
  family                     = "var.family"
  description                = "This a Back ofice DevOps"

  subnet_ids         = module.vpc.public_subnet_ids
  vpc_id             = module.vpc.vpc_id
  source_cidr_blocks = [module.vpc.vpc_cidr_block]

  tags = {
    Environment = "prod"
  }
}

data "aws_availability_zones" "available" {}
