terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.37.0"
    }
  }
  # whilst the `version` attribute is optional, I recommend pinning to a given version of the Provider
  required_version = "= 0.13.2"
}

provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  #  version = "~>2.25.0"
  features {
    key_vault {
      recover_soft_deleted_key_vaults = true
      purge_soft_delete_on_destroy    = false
    }
  }
  subscription_id = var.az_subscription_id
  tenant_id       = var.az_tenant_id
  client_id       = var.az_client_id
  client_secret   = var.az_client_secret
}

provider "azuread" {
  tenant_id       = var.az_tenant_id
  client_id       = var.az_client_id
  client_secret   = var.az_client_secret
}