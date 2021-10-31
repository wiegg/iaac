terraform {
  backend "azurerm" {
  }

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.31.1"
    }
  }
}

provider "hcloud" {
  token = var.token
}

data "hcloud_ssh_key" "private_key" {
  fingerprint = "7f:fd:f1:d0:4a:56:a9:70:db:9c:3e:4b:3c:52:7a:81"
}

resource "hcloud_network" "network" {
  name     = "network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "subnet" {
  type         = "cloud"
  network_id   = hcloud_network.network.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_server" "node1" {
  name        = "node1"
  image       = "ubuntu-20.04"
  server_type = "cx11"
  location    = "nbg1"

  ssh_keys = [data.hcloud_ssh_key.private_key.id]

  network {
    network_id = hcloud_network.network.id
    ip         = "10.0.1.5"
  }
}

resource "hcloud_server" "db1" {
  name        = "db1"
  image       = "ubuntu-20.04"
  server_type = "cx11"
  location    = "nbg1"

  ssh_keys = [data.hcloud_ssh_key.private_key.id]

  labels = { redis = 1 }

  network {
    network_id = hcloud_network.network.id
    ip         = "10.0.1.6"
  }
}
