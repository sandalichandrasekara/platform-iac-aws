locals {
  tags = merge(var.tags, { ManagedBy = "terraform" })
}

# ---------------------------------------------------------------------------
# Backup vault (where recovery points are stored)
# ---------------------------------------------------------------------------
resource "aws_backup_vault" "this" {
  name = "${var.name_prefix}-vault"
  tags = local.tags
}

# ---------------------------------------------------------------------------
# IAM role AWS Backup assumes to run backups
# ---------------------------------------------------------------------------
data "aws_iam_policy_document" "backup_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "backup" {
  name               = "${var.name_prefix}-backup-role"
  assume_role_policy = data.aws_iam_policy_document.backup_assume.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "backup" {
  role       = aws_iam_role.backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

# ---------------------------------------------------------------------------
# Backup plan + selection
# ---------------------------------------------------------------------------
resource "aws_backup_plan" "this" {
  name = "${var.name_prefix}-plan"

  rule {
    rule_name         = "daily"
    target_vault_name = aws_backup_vault.this.name
    schedule          = var.schedule

    lifecycle {
      delete_after = var.retention_days
    }
  }

  tags = local.tags
}

resource "aws_backup_selection" "this" {
  name         = "${var.name_prefix}-selection"
  plan_id      = aws_backup_plan.this.id
  iam_role_arn = aws_iam_role.backup.arn
  resources    = var.resource_arns
}
