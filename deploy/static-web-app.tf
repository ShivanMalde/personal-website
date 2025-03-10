resource "azurerm_static_web_app" "websiteStaticWebApp" {
  name                = local.websiteStaticWebAppName
  resource_group_name = azurerm_resource_group.websiteResourceGroup.name
  location            = "West Europe"
  sku_size            = "Free"
  sku_tier            = "Free"
  lifecycle {
    ignore_changes = [repository_branch, repository_token, repository_url]
  }
}