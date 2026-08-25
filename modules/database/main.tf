locals {
  tags = merge(var.tags, { ManagedBy = "terraform" })
}

# ---------------------------------------------------------------------------
# Master password -> Secrets Manager (never hard-code credentials)
# ---------------------------------------------------------------------------
resource "random_password" "master" {
  length  = 24
  special = false # DocumentDB disallows several special chars; keep it simple
}

resource "aws_secretsmanager_secret" "db" {
  name                    = "${var.name_prefix}-docdb-credentials"
  recovery_window_in_days = var.secret_recovery_window_days
  tags                    = local.tags
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.master_username
    password = random_password.master.result
    host     = aws_docdb_cluster.this.endpoint
    port     = var.port
  })
}

# ---------------------------------------------------------------------------
# DocumentDB (MongoDB-compatible) cluster
# ---------------------------------------------------------------------------
resource "aws_docdb_subnet_group" "this" {
  name       = "${var.name_prefix}-docdb-subnets"
  subnet_ids = var.subnet_ids
  tags       = local.tags
}

# Enforce in-transit TLS and enable audit logging at the cluster level.
resource "aws_docdb_cluster_parameter_group" "this" {
  name        = "${var.name_prefix}-docdb-params"
  family      = var.parameter_group_family
  description = "TLS enforced, audit logs enabled for ${var.name_prefix}."

  parameter {
    name  = "tls"
    value = "enabled"
  }

  parameter {
    name  = "audit_logs"
    value = "enabled"
  }

  tags = local.tags
}

resource "aws_docdb_cluster" "this" {
  cluster_identifier              = "${var.name_prefix}-docdb"
  engine                          = "docdb"
  master_username                 = var.master_username
  master_password                 = random_password.master.result
  port                            = var.port
  db_subnet_group_name            = aws_docdb_subnet_group.this.name
  vpc_security_group_ids          = var.security_group_ids
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.this.name

  storage_encrypted   = true
  kms_key_id          = var.kms_key_id # null => AWS-managed key
  deletion_protection = var.deletion_protection

  backup_retention_period = var.backup_retention_days
  preferred_backup_window = var.preferred_backup_window

  # Ship engine logs to CloudWatch for auditing/troubleshooting.
  enabled_cloudwatch_logs_exports = ["audit", "profiler"]

  # Keep a final snapshot unless explicitly skipped (skip only in throwaway envs).
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.name_prefix}-docdb-final"

  tags = merge(local.tags, { Name = "${var.name_prefix}-docdb" })
}

resource "aws_docdb_cluster_instance" "this" {
  count              = var.instance_count
  identifier         = "${var.name_prefix}-docdb-${count.index + 1}"
  cluster_identifier = aws_docdb_cluster.this.id
  instance_class     = var.instance_class

  tags = merge(local.tags, { Name = "${var.name_prefix}-docdb-${count.index + 1}" })
}
