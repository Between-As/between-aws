resource "aws_kms_key" "backup_vault_key" {
  description = "KMS key for Backup Vault"

  tags = merge(
    tomap({ "Name" = format("%s-%s", local.tag_environment, "backup-vault") }),
    var.common_tags
  )
}

resource "aws_kms_alias" "alias" {
  name          = "alias/backup-vault-key"
  target_key_id = aws_kms_key.backup_vault_key.key_id
}
