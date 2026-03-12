terraform {
  source = "${get_path_to_repo_root()}/iac/week-4/demo-7/modules/cvm"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment = local.env_vars.locals.environment
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  cvm_name                = "department1-team1-cvm"
}