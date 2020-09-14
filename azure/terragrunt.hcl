remote_state {
  backend = "azurerm"
  config = {
    storage_account_name = "ecdeploy"
    container_name       = "terraformbackend"
    key                  = "${get_env("TF_VAR_APP_NAME","")}/terraform.tfstate"
  }
}