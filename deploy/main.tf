terraform {
  required_providers {
    azurerm = {
      version = "~>4.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "shared-rg"
    storage_account_name = "shivantfstatestorage"
    container_name = "tfstate"
    key = "personal-website.terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "b3d213a8-bf35-48f0-86d0-46dc0e727d98" # Sandbox
  features {
    
  }
}

locals {
  subscriptionId = "b3d213a8-bf35-48f0-86d0-46dc0e727d98"
  websiteResourceGroupName = "shivan-website-weu-rg"
  websiteStaticWebAppName = "shivan-website-weu-stapp"
}

resource "azurerm_resource_group" "websiteResourceGroup" {
  name = local.websiteResourceGroupName
  location = "West Europe"
}