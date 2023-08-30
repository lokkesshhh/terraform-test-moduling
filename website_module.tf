module "azure_static_website" {
    source = "./modules/azure_static_website"
    # name                = module.
  # resource_group_name = azurerm_resource_group.resource_group.name

  # location                 = var.location
  # account_tier             = var.storage_account_tier
  # account_replication_type = var.storage_account_replication_type
  # account_kind             = var.storage_account_kind

location                          = "eastus"
resource_group_name               = "myrg1"
storage_account_name              = "staticwebsite"
storage_account_tier              = "Standard"
storage_account_replication_type  = "LRS"
storage_account_kind              = "StorageV2"
static_website_index_document     = "index.html"
static_website_error_404_document = "error.html"
  
}