terraform {
  required_providers {
    azurerm = {
      version = "~>3.52"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "websiteResourceGroup" {
  name = var.websiteResourceGroupName
  location = "West Europe"
}

resource "azurerm_static_site" "websiteStaticWebApp" {
  name = var.websiteStaticWebAppName
  resource_group_name = azurerm_resource_group.websiteResourceGroup.name
  location = "West Europe"
  sku_size = "Free"
  sku_tier = "Free"
}