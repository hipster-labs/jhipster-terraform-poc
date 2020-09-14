variable "region" {
  type = string
}
variable "name" {
  type = string
}

variable "database_version" {
  default = "POSTGRES_12"
  type = string
}
variable "disk_size" {
  default = 10
  type = number
}

variable "network_self_link" {
  type = string
}

variable "database_name" {
  type = string
}

variable "database_user" {
  type = string
}

variable "database_password" {
  type = string
}

