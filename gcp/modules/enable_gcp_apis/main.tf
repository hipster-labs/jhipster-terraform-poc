resource "google_project_service" "enable_api" {
  for_each = toset(values({for i, r in var.apis_to_enable:  i => r}))

  project = var.project
  service = each.value

  disable_dependent_services = true
}