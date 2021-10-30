terraform {
  backend "azurerm" {
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
  image = "ubuntu-20.04"
  server_type = "cx11"
  location = "nbg1"
}