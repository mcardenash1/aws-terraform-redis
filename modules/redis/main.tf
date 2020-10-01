resource "aws_elasticache_replication_group" "default" {
  engine               = "redis"
  parameter_group_name = aws_elasticache_parameter_group.default.name
  subnet_group_name    = aws_elasticache_subnet_group.default.name
  security_group_ids   = [aws_security_group.default.id]

  replication_group_id = var.name
  number_cache_clusters = var.number_cache_clusters
  node_type = var.node_type
  engine_version = var.engine_version
  port = var.port
  maintenance_window = var.maintenance_window
  snapshot_window = var.snapshot_window
  snapshot_retention_limit = var.snapshot_retention_limit
  automatic_failover_enabled = var.automatic_failover_enabled
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled

  apply_immediately = var.apply_immediately
  replication_group_description = var.description

  tags = merge({ "Name" = var.name }, var.tags)
}

resource "aws_elasticache_parameter_group" "default" {
  name        = var.name
  family      = var.family
  description = var.description
}

resource "aws_elasticache_subnet_group" "default" {
  name        = var.name
  subnet_ids  = var.subnet_ids
  description = var.description
}

resource "aws_security_group" "default" {
  name   = local.security_group_name
  vpc_id = var.vpc_id
  tags   = merge({ "Name" = local.security_group_name }, var.tags)
}

locals {
  security_group_name = "${var.name}-elasticache-redis"
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.source_cidr_blocks
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}


#
# CloudWatch Resources
#
resource "aws_cloudwatch_metric_alarm" "cache_cpu" {
  count               = module.this.enabled && var.cloudwatch_metric_alarms_enabled ? local.member_clusters_count : 0
  alarm_name          = "cpu-utilization"
  alarm_description   = "Redis cluster CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"

  threshold = var.alarm_cpu_threshold_percent

  dimensions = {
    CacheClusterId = element(local.elasticache_member_clusters, count.index)
  }

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions
  depends_on    = [aws_elasticache_replication_group.default]
}

resource "aws_cloudwatch_metric_alarm" "cache_memory" {
  count               = module.this.enabled && var.cloudwatch_metric_alarms_enabled ? local.member_clusters_count : 0
  alarm_name          = "${element(local.elasticache_member_clusters, count.index)}-freeable-memory"
  alarm_description   = "Redis cluster freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = "60"
  statistic           = "Average"

  thmodulereshold = var.alarm_memory_threshold_bytes

  dimensions = {
    CacheClusterId = element(local.elasticache_member_clusters, count.index)
  }

  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions
  depends_on    = [aws_elasticache_replication_group.default]
}
