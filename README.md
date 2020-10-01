# terraform-aws-redis(elasticache)

Terraform project creates Redis resources on AWS.

## Description

This project provides recommended settings:

- Enable Multi-AZ
- Enable automatic failover
- Enable at-rest encryption
- Enable in-transit encryption
- Enable automated backups

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.12 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

## Note
In inventory.tfvars have information about some redis config Vars and permit to start different environments from the same code. 
## Inputs

| Name                       | Description                                                                                                               | Type           | Default                  | Required |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------- | -------------- | ------------------------ | :------: |
| name                       | The replication group identifier. This parameter is stored as a lowercase string.                                         | `string`       | n/a                      |   yes    |
| node_type                  | The compute and memory capacity of the nodes in the node group.                                                           | `string`       | n/a                      |   yes    |
| number_cache_clusters      | The number of cache clusters (primary and replicas) this replication group will have.                                     | `string`       | n/a                      |   yes    |
| source_cidr_blocks         | List of source CIDR blocks.                                                                                               | `list(string)` | n/a                      |   yes    |
| subnet_ids                 | List of VPC Subnet IDs for the cache subnet group.                                                                        | `list(string)` | n/a                      |   yes    |
| vpc_id                     | VPC Id to associate with Redis ElastiCache.                                                                               | `string`       | n/a                      |   yes    |
| apply_immediately          | Specifies whether any modifications are applied immediately, or during the next maintenance window.                       | `bool`         | `false`                  |    no    |
| at_rest_encryption_enabled | Whether to enable encryption at rest.                                                                                     | `bool`         | `true`                   |    no    |
| automatic_failover_enabled | Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. | `bool`         | `true`                   |    no    |
| description                | The description of the all resources.                                                                                     | `string`       | `"Managed by Terraform"` |    no    |
| engine_version             | The version number of the cache engine to be used for the cache clusters in this replication group.                       | `string`       | `"5.0.6"`                |    no    |
| family                     | The family of the ElastiCache parameter group.                                                                            | `string`       | `"redis5.0"`             |    no    |
| maintenance_window         | Specifies the weekly time range for when maintenance on the cache cluster is performed.                                   | `string`       | `""`                     |    no    |
| port                       | The port number on which each of the cache nodes will accept connections.                                                 | `number`       | `6379`                   |    no    |
| snapshot_retention_limit   | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them.              | `number`       | `30`                     |    no    |
| snapshot_window            | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster.          | `string`       | `""`                     |    no    |
| tags                       | A mapping of tags to assign to all resources.                                                                             | `map(string)`  | `{}`                     |    no    |
| transit_encryption_enabled | Whether to enable encryption in transit.                                                                                  | `bool`         | `true`                   |    no    |

## Outputs

| Name                                                   | Description                                                                |
| ------------------------------------------------------ | -------------------------------------------------------------------------- |
| elasticache_parameter_group_id                         | The ElastiCache parameter group name.                                      |
| elasticache_replication_group_id                       | The ID of the ElastiCache Replication Group.                               |
| elasticache_replication_group_member_clusters          | The identifiers of all the nodes that are part of this replication group.  |
| elasticache_replication_group_primary_endpoint_address | The address of the endpoint for the primary node in the replication group. |
| security_group_arn                                     | The ARN of the Redis ElastiCache security group.                           |
| security_group_description                             | The description of the Redis ElastiCache security group.                   |
| security_group_egress                                  | The egress rules of the Redis ElastiCache security group.                  |
| security_group_id                                      | The ID of the Redis ElastiCache security group.                            |
| security_group_ingress                                 | The ingress rules of the Redis ElastiCache security group.                 |
| security_group_name                                    | The name of the Redis ElastiCache security group.                          |
| security_group_owner_id                                | The owner ID of the Redis ElastiCache security group.                      |
| security_group_vpc_id                                  | The VPC ID of the Redis ElastiCache security group.                        |

### Installation

```shell
#git clone git@github.com:mcardenash1/aws-terraform-redis.git
extract the file aws-terraform-redis.zip
cd aws-terraform-redis
/bin/bash script/main.sh build
```

### Destroy

```shell
/bin/bash script/main.sh destroy
```