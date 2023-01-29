resource "aws_kms_key" "vault-key" {
  description = "KMS key for Vault"

  tags = merge(
    tomap({ "Name" = format("%s-%s", "vault-key-", local.tag_environment) }),
    var.common_tags
  )
}

resource "aws_kms_alias" "alias" {
  name          = "alias/eks-vault-key"
  target_key_id = aws_kms_key.vault-key.key_id
}
