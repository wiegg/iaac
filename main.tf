terraform {
  backend "azurerm" {
    resource_group_name = var.backend_rg_name
  }

  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.31.1"
    }
  }
}

provider "hcloud" {
  token = var.token
}

resource "hcloud_server" "node1" {
  name = "node1"
  image = "debian-9"
  server_type = "cx11"

  firewall_ids = [hcloud_firewall.firewall.id]
}

resource "hcloud_firewall" "firewall" {
  name = "firewall"
  rule {
    direction = "in"
    protocol = "tcp"
    port = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "out"
    protocol = "tcp"
    port = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}