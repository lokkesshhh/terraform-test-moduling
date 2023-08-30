# # terraform block
# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "3.69.0"
#     }
#     #   }
#     # }


#     random = {
#       source  = "hashicorp/random"
#       version = "3.5.1"
#     }
#   }
#   #  backend "azurerm" {
#   #   resource_group_name  = "CloudOps-merarg"
#   #   storage_account_name = "storagea98038"
#   #   container_name       = "terrafrom-state-files-container"
#   #   key                  = "prod.terraform.tfstate"
#   # }
# }


# # provider block
# provider "azurerm" {
#   # Configuration options
#   features {

#   }
# }
# # provider blccok2 
# provider "azurerm" {
#   alias = "provider2-westUS"
#   features {
#     virtual_machine {
#       delete_os_disk_on_deletion = "false"
#     }

#   }

# }
# provider "random" {

#   # config

# }
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
}

# Provider Block
provider "azurerm" {
  features {}
}

