resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "sql_database_instance" {
  // A random part in the name is mandatory since GCP is keeping name of previous instances for up to 2 months
  name             = "${var.name}-database-${random_id.db_name_suffix.hex}"
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = "db-f1-micro"
    disk_size         = var.disk_size
    availability_type = "REGIONAL"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_self_link
      //require_ssl     = true
    }

    backup_configuration {
      enabled    = false
      start_time = "00:00" # UTC time
    }

    maintenance_window {
      day          = 7 # Sunday
      hour         = 1 # 1am UTC time
      update_track = "stable"
    }
  }

  timeouts {
    create = "15m"
    update = "30m"
  }
  // google_sql_database_instance does not actually interpolate values from google_service_networking_connection.
  // You must explicitly add a depends_onreference as shown below.
  // See https://www.terraform.io/docs/providers/google/r/sql_database_instance.html
  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "db-module" {
  name     = var.database_name
  instance = google_sql_database_instance.sql_database_instance.name
}

resource "google_sql_user" "user-module" {
  name     = var.database_user
  instance = google_sql_database_instance.sql_database_instance.name
  password = var.database_password
}
