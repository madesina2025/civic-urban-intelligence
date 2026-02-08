# # terraform block used to configure some high level behaviors of Terraform

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "=4.1.0"
#     }
#   }
# }


# # Cinfigure the Microsoft Azure Providers 

# provider "azurerm" {
#   features {}
#   subscription_id = "ddb16f9b-3b4b-4392-b2ed-2e0b23126781"
# }

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = trimspace(file("credentials.txt"))
}

