locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  secret_id = get_env("${local.env_vars.locals.secret_id_env}")
  secret_key = get_env("${local.env_vars.locals.secret_key_env}")
}

remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
}

// generate "backend" {
//   path      = "backend.tf"
//   if_exists = "overwrite_terragrunt"
//   contents = <<EOF
// terraform {
//   backend "cos" {
//     region = "ap-guangzhou"
//     # fix me with appid
//     bucket = "bucket-for-terraform-state-1301578102"
//     prefix = "terraform/state"
//   }
// }
// EOF
// }

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "tencentcloud" {
    region = "ap-guangzhou"
    secret_id = "${local.secret_id}"
    secret_key = "${local.secret_key}"
}
EOF
}