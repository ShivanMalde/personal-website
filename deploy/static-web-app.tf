resource "azurerm_static_web_app" "websiteStaticWebApp" {
  name                = local.websiteStaticWebAppName
  resource_group_name = azurerm_resource_group.websiteResourceGroup.name
  location            = "West Europe"
  sku_size            = "Free"
  sku_tier            = "Free"
}

import {
  to = azurerm_static_web_app.websiteStaticWebApp
  id = "/subscriptions/b3d213a8-bf35-48f0-86d0-46dc0e727d98/resourceGroups/shivan-website-weu-rg/providers/Microsoft.Web/staticSites/shivan-website-weu-stapp"
}