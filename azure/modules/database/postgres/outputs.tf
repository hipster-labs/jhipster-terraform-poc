output "postgres_id" {
  value = "${azurerm_postgresql_server.default.id}"
}

output "postgres_fqdn" {
  value = "${azurerm_postgresql_server.default.fqdn}"
}