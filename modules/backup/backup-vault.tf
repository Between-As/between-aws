resource "aws_backup_vault" "vault" {
  name        = "${local.tag_environment}-backup-vault"
  kms_key_arn = aws_kms_key.backup_vault_key.arn

  tags = merge(
    tomap({ "Name" = format("%s-%s", local.tag_environment, "backup-vault") }),
    var.common_tags
  )
}
