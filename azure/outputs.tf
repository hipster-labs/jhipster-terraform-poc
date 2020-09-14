output "k8s_resource_group" {
  value = "${module.main.k8s_resource_group}"
}

output "k8s_service_principal_object_id" {
  value = "${module.main.k8s_service_principal_object_id}"
}

output "service_sp_name" {
  value = "${module.main.service_sp_name}"
}

output "service_sp_password" {
  value = "${module.main.service_sp_password}"
}
