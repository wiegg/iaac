variable "token" {
  sensitive = true
  description = "The Hetzner Cloud API token"
}

variable "backend_rg_name" {
  type = string
  description = "The State Storage Account Resource Group Name"
}

variable "backend_storage_account_name" {
  type = string
  description = "The State Storage Account Name"
}

variable "backend_container_name" {
  type = string
  description = "The State Storage Container Name"
}

variable "backend_key" {
  type = string
  description = "The State Storage Key"
}

variable "backend_ak" {
  type = string
  sensitive = true
  description = "The State Access Key"
}