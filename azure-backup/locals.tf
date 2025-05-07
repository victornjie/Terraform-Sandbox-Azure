locals {
  # The Name which should be used for this Resource Group
  eus2_rg_vault_name = "rg-test-vault-eus2"
  cus_rg_vault_name  = "rg-test-vault-cus"

  # The prefix Name which should be used for this Resource Group
  eus2_prefix = "test-eus2-backup"
  cus_prefix  = "test-cus-backup"

  # Specifies the name of the Recovery Services Vault
  eus2_vault_name = "test-vault-eus2"
  cus_vault_name  = "test-vault-cus"

  # A mapping of tags to assign to the resource
  user_defined_tags = {
    "Environment" : "Demo",
    "Owner" : "VictorMbock"
    "Department" : "Local"
  }


}
