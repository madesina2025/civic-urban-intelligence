# variable "resource_group_name" {
#     description = "resource group for all resources"
#     default = "amdariresource"
# }

# variable "location" {
#     default = "East US"
# }

variable "resource_group_name" {
  type    = string
  default = "amdarirgmk01" # NEW name
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "storage_account_name" {
  type = string
  # must be globally unique, lowercase letters & numbers only
  default = "amdaristorageuk01" # NEW name
}

variable "pg_admin_password" {
  type      = string
  sensitive = true
}
