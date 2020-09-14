resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  # count               = "${length(var.resource_group_location)}"
  name                = "${var.cluster_name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
  dns_prefix          = "${var.dns_prefix}"
  kubernetes_version  = "${var.k8s_version}"

  agent_pool_profile {
    name            = "default"
    count           = "${var.nb_instances}"
    vm_size         = "${var.vm_size}"
    os_type         = "${var.os_type}"
    os_disk_size_gb = "${var.vm_disk_size}"
    vnet_subnet_id  = "${data.azurerm_subnet.default.id}"
  }

  linux_profile {
    ssh_key {
      key_data = "${file("~/.ssh/id_rsa.pub")}"
    }

    admin_username = "${var.admin_username}"
  }

  network_profile {
    network_plugin = "${var.network_plugin}"
  }


  service_principal {
    client_id     = "your_id"
    client_secret = "your_secret"
  }

  tags = {
    Environment = "${var.environment}"
  }
}
