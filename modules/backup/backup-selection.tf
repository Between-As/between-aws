resource "aws_backup_selection" "selection" {
  iam_role_arn = aws_iam_role.role_backup.arn
  name         = "${local.tag_environment}-daily-backup-selection"
  plan_id      = aws_backup_plan.daily_plan.id

  resources    = var.backuped_resources
}
