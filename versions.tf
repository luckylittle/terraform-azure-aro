terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.37.0"
    }
  }
  # whilst the `version` attribute is optional, I recommend pinning to a given version of the Provider
  required_version = "= 0.13.5"
}

provider "azurerm" {
  features {}
}
