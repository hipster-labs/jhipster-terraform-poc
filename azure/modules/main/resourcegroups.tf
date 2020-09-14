resource "azurerm_resource_group" "jhipster_rg" {
  location = "${var.location}"
  name     = "${var.app_name}_${var.rg_name}"
  tags = {
    Environment = "${var.environment}"
    Env_Version = "${var.env_version}"
  }
}
