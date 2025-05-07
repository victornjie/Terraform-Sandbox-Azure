module "recovery_services_vault_eus2" {
  source = "./modules/backup-vault"

  rg_vault_name     = "rg-test-vault-eus2"
  location          = "EastUS2"
  vault_name        = "test-vault-eus2"
  immutability      = "Unlocked"

  user_defined_tags = local.user_defined_tags
}

module "backup_policies_eus2" {
  source = "./modules/backup-policy"

  recovery_vault_name = module.recovery_services_vault_eus2.recovery_vault_name
  resource_group_name = module.recovery_services_vault_eus2.recovery_vault_resource_group_name
  vm_policy_name      = "vm-dev-backup-policy-eus2"
  sql_policy_name     = "sql-dev-backup-policy-eus2"
  prefix              = "test-eus2-backup"

  prod_vault = "false"

  user_defined_tags = local.user_defined_tags
}


module "recovery_services_vault_cus" {
  source = "./modules/backup-vault"

  rg_vault_name     = "rg-test-vault-cus"
  location          = "CentralUS"
  vault_name        = "test-vault-cus"
  immutability      = "Locked"

  user_defined_tags = local.user_defined_tags
}

module "backup_policies_cus" {
  source = "./modules/backup-policy"

  recovery_vault_name = module.recovery_services_vault_cus.recovery_vault_name
  resource_group_name = module.recovery_services_vault_cus.recovery_vault_resource_group_name
  vm_policy_name      = "vm-prod-backup-policy-cus"
  sql_policy_name     = "sql-prod-backup-policy-cus"
  prefix              = "test-cus-backup"

  prod_vault = "true"

  user_defined_tags = local.user_defined_tags
}