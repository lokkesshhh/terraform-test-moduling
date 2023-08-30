# # resource "azurerm_resource_group" "azrm" {

# # #   for_each = {
# # #     dc1-apps = "eastus"
# # #     dc2-apps = "eastus2"
# # #     dc3-apps = "westus"
# # #   }
# # #   name     = "${each.key}-rg"
# # #   location = each.value

# # # for_each = toset(["eastus", "eastus2", "westus"])
# # # name = "rg-${each.key}"
# # # location=each.value


# # }


resource "azurerm_resource_group" "azrg" {

  count    = length(var.env2)
  name     = "${local.rg_name}-${count.index}-rg"
  location = var.location

}

resource "azurerm_resource_group" "azrm" {
  # for_each = var.env
  # count = 3
  name = "${var.business_unit}-${var.resource_group_name}"
  # name     = "my-resource-group_${count.index}"
  location = var.location

  tags = {
    "addition" = "minus"
  }
}

resource "random_string" "new1" {
  # for_each = var.env
  length  = 16
  special = false
  upper   = false
}

# module "vnet" {
#   source  = "Azure/vnet/azurerm"
#   version = "4.1.0"
#   # insert the 3 required variables here
#   resource_group_name = local.rg_name
#   use_for_each = false
#   # for_each            = var.env
#   vnet_location       = azurerm_resource_group.azrm.location
#   depends_on          = [azurerm_resource_group.azrm]
#   address_space       = (var.env != "pat" ? var.virtual_network_address_space_for_dev : ["10.0.0.0/24"])
#   subnet_names        = ["subnet1", "subnet2", "subnet3"]
#   subnet_prefixes = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
# }
# resource "azurerm_virtual_network" "vmnetwork" {

#   # for_each = var.env

#   count               = (var.env == "dev" ? 1 : 3)
#   name                = "${local.vnet_name}-${count.index}"
#   location            = azurerm_resource_group.azrm.location
#   resource_group_name = local.rg_name
#   address_space       = (var.env != "pat" ? var.virtual_network_address_space_for_dev : ["10.0.0.0/24"])
#   # dns_servers         = ["10.0.0.4", "10.0.0.5"]
#   tags = var.common_tags

# }


resource "azurerm_storage_account" "storage_account" {
  name                = "storagea98038"
  resource_group_name = azurerm_resource_group.azrm.name
 
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
 
  static_website {
    index_document = var.static_website_index_document
    error_404_document = var.static_website_error_404_document  
  
  }
}



# resource "azurerm_subnet" "sn1" {

#   for_each             = var.env
#   name                 = "${azurerm_virtual_network.vmnetwork[each.key].name}-subnte1"
#   resource_group_name  = azurerm_resource_group.azrm.name
#   virtual_network_name =mo
#   address_prefixes     = module.vnet.vnet_address_space
# }



# resource "azurerm_public_ip" "pubip" {

#   #        lifecycle {
#   #   prevent_destroy = true
#   # }

#   # depends_on = [ azurerm_virtual_network.vmnetwork,
#   # azurerm_subnet.sn1 ]
#   # count =1
#   name                = "acceptanceTestPublicIp-${var.resource_group_name}"
#   resource_group_name = azurerm_resource_group.azrm.name
#   location            = azurerm_resource_group.azrm.location
#   allocation_method   = "Static"
#   domain_name_label   = "check-string"
#   sku                 = "Standard"

#   tags = {
#     environment = "Production"
#   }
# }

# # element(list,id)
# # lookup(map,key,default)
# # # resource "azurerm_public_ip" "pubip" {
# # #   for_each = toset(["vm1", "vm2"])

# # #   #   depends_on = [
# # #   #     azurerm_virtual_network.vmnetwork,
# # #   #     azurerm_network_interface.vmnic
# # #   #   ]

# # #   #   depends_on = [ azurerm_virtual_network.vmnetwork,
# # #   #   azurerm_subnet.sn1 ]
# # #   #   count               = 2
# # #   name                = "pbip-${each.key}"
# # #   resource_group_name = azurerm_resource_group.azrm.name
# # #   location            = azurerm_resource_group.azrm.location
# # #   allocation_method   = "Static"

# # #   domain_name_label = "check-string${random_string.new1.id}${each.key}"

# # #   tags = {
# # #     environment = "Production"
# # #   }
# # # }


# resource "azurerm_network_interface" "vmnic" {
#   depends_on = [ module.vnet ]
#   #   count               = 2
#   # for_each = toset(["vm1", "vm2"])
#   #   name                = "vmnic${count.index}"
#   name                = "vmnic-${module.vnet.vnet_name}"
#   location            = module.vnet.vnet_location
#   resource_group_name = azurerm_resource_group.azrm.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = module.vnet.vnet_subnets[0]
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pubip.id #key is equal to the name of pbip=pbip-vm1
#     # element(azurerm_public_ip.pubip[*].id,count.index)
#   }
# }


# resource "azurerm_linux_virtual_machine" "linux_machine" {
#     # count = 2
#  for_each = azurerm_network_interface.vmnic
#   name                  = "mymachine-linux${each.key}"
#   location              = azurerm_resource_group.azrm.location
#   resource_group_name   = azurerm_resource_group.azrm.name
#   admin_username        = "lokesh"
#   size                  = "Standard_DS1_v2"
# #   network_interface_ids = element([azurerm_network_interface.vmnic[*].id],count.index)
# network_interface_ids = [azurerm_network_interface.vmnic[each.key].id]

#   admin_ssh_key {
#     username   = "lokesh"
#     public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
#   }
#   os_disk {
#     name                 = "OSDISK${each.key}"
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts"
#     version   = "latest"
#   }
# connection {
#   type = "ssh"
#   host = self.public_ip_address
# }
# }

