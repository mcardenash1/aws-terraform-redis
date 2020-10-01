#---AWS

region = "us-east-2"

#---VPC
vpc_cidr_block = "172.16.0.0/16"

#----subnets
availability_zones = ["us-east-2a", "us-east-2b"]

#--------Redis


# The replication group identifier. This parameter is stored as a lowercase string.
name = "redis-cluster"

# The number of clusters this replication group initially has.
# If automatic_failover_enabled is true, the value of this parameter must be at least 2.
# The maximum permitted value for number_cache_clusters is 6 (1 primary plus 5 replicas).
number_cache_clusters = 5

# The compute and memory capacity of the nodes in the node group (shard).
# Generally speaking, the current generation types provide more memory and computational power at lower cost
node_type = "cache.t2.micro"

# The version number of the cache engine to be used for the clusters in this replication group.
# You can upgrade to a newer engine version, but you cannot downgrade to an earlier engine version.
engine_version = "4.0.10"

# The port number on which each member of the replication group accepts connections.
# Redis default port is 6379.
port = 6379

# Specifies the weekly time range during which maintenance on the cluster is performed.
# The minimum maintenance window is a 60 minute period.
maintenance_window = "mon:10:40-mon:11:40"

# A period during each day when ElastiCache will begin creating a backup.
# The minimum length for the backup window is 60 minutes.
snapshot_window = "06:30-07:30"

# The number of days the backup will be retained in Amazon S3.
# The maximum backup retention limit is 35 days.
# If the backup retention limit is set to 0, automatic backups are disabled for the cluster.
snapshot_retention_limit = 30

# You can enable Multi-AZ with Automatic Failover only on Redis (cluster mode disabled) clusters that have at least
# one available read replica. Clusters without read replicas do not provide high availability or fault tolerance.
# https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/AutoFailover.html
automatic_failover_enabled = true

# Redis at-rest encryption is an optional feature to increase data security by encrypting on-disk data during sync
# and backup or snapshot operations. Because there is some processing needed to encrypt and decrypt the data,
# enabling at-rest encryption can have some performance impact during these operations.
# You should benchmark your data with and without at-rest encryption to determine the performance impact for your use cases.
at_rest_encryption_enabled = false

# ElastiCache in-transit encryption is an optional feature that allows you to increase the security of your data at
# its most vulnerable points—when it is in transit from one location to another. Because there is some processing
# needed to encrypt and decrypt the data at the endpoints, enabling in-transit encryption can have some performance impact.
# You should benchmark your data with and without in-transit encryption to determine the performance impact for your use cases.
transit_encryption_enabled = true

# If true, this parameter causes the modifications in this request and any pending modifications to be applied,
# asynchronously and as soon as possible, regardless of the maintenance_window setting for the replication group.
# apply_immediately applies only to modifications in node type, engine version, and changing the number of nodes in a cluster.
# Other modifications, such as changing the maintenance window, are applied immediately.
apply_immediately = false

family = "redis5.0"

cloudwatch_metric_alarms_enabled = false





