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
  name = "${var.name_prefix}-docdb-credentials"
  tags = local.tags
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

resource "aws_docdb_cluster" "this" {
  cluster_identifier     = "${var.name_prefix}-docdb"
  engine                 = "docdb"
  master_username        = var.master_username
  master_password        = random_password.master.result
  port                   = var.port
  db_subnet_group_name   = aws_docdb_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids

  storage_encrypted   = true
  skip_final_snapshot = true # lean/dev default; set false for prod

  tags = merge(local.tags, { Name = "${var.name_prefix}-docdb" })
}

resource "aws_docdb_cluster_instance" "this" {
  count              = var.instance_count
  identifier         = "${var.name_prefix}-docdb-${count.index + 1}"
  cluster_identifier = aws_docdb_cluster.this.id
  instance_class     = var.instance_class

  tags = merge(local.tags, { Name = "${var.name_prefix}-docdb-${count.index + 1}" })
}
