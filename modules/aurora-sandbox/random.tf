resource "random_string" "aurora_postgres_master_password" {
  length  = 24
  special = false

  keepers = {
    master_password_seed = var.aurora_postgres_master_password_seed
  }
}
