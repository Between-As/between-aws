resource "aws_backup_plan" "daily_plan" {
  name = "${local.tag_environment}-daily-backup-plan"

  rule {
    rule_name         = "${local.tag_environment}-daily-backup"
    target_vault_name = aws_backup_vault.vault.name
    schedule          = var.schedule

    lifecycle {
      delete_after = var.lifecycle_retention
    }
  }

  tags = merge(
    tomap({ "Name" = format("%s-%s", local.tag_environment, "daily-backup-plan") }),
    var.common_tags
  )
}
