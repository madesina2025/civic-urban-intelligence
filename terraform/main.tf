
# Create a resource group
resource "azurerm_resource_group" "amdariresourceMK" {
  name     = var.resource_group_name
  location = var.location
}

# Create a storage account
resource "azurerm_storage_account" "amdaristorageMK" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.amdariresourceMK.name
  location                 = azurerm_resource_group.amdariresourceMK.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# Create a blob container
resource "azurerm_storage_container" "rawstoragecontainer" {
  name                  = "raw2"
  storage_account_name  = azurerm_storage_account.amdaristorageMK.name
  container_access_type = "private"
}

# Create a blob container
resource "azurerm_storage_container" "cleanstoragecontainer" {
  name                  = "clean2"
  storage_account_name  = azurerm_storage_account.amdaristorageMK.name
  container_access_type = "private"
}

resource "azurerm_data_factory" "amdarifactory_tf" {
  name                = "amdarifactory-tf"
  location            = azurerm_resource_group.amdariresourceMK.location
  resource_group_name = azurerm_resource_group.amdariresourceMK.name
}

data "azurerm_storage_account" "storageaccountdata" {
  name                = "amdaristorageuk01"
  resource_group_name = "amdarirgmk01"
  depends_on          = [azurerm_storage_account.amdaristorageMK]
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "amdarilnkdsrvc" {
  name              = "amdari_blob_storage_ls"
  data_factory_id   = azurerm_data_factory.amdarifactory_tf.id
  connection_string = data.azurerm_storage_account.storageaccountdata.primary_connection_string
}

# resource "azurerm_data_factory_dataset_parquet" "amdariparquet" {
#   name                = "311_parquet_file"
#   data_factory_id     = azurerm_data_factory.amdarifactory_tf.id
#   linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.amdarilnkdsrvc.name

#   http_server_location {
#     relative_url = "http://www.bing.com"
#     path         = "foo/bar/"
#     filename     = "fizz.txt"
#   }
# }


resource "azurerm_postgresql_flexible_server" "pg" {
  name                   = "amdarissvr-trf"
  resource_group_name    = azurerm_resource_group.amdariresourceMK.name
  location               = azurerm_resource_group.amdariresourceMK.location
  version                = "12"
  administrator_login    = "pgadminmk"
  administrator_password = var.pg_admin_password
  storage_mb             = 32768
  sku_name               = "GP_Standard_D4s_v3"

  lifecycle {
    ignore_changes = [
      zone,
      high_availability
    ]
  }
}

resource "azurerm_postgresql_flexible_server_database" "appdb" {
  name      = "amdaridb-tf"
  server_id = azurerm_postgresql_flexible_server.pg.id
  collation = "en_US.utf8"
  charset   = "UTF8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}


resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all" {
  name             = "allow-all"
  server_id        = azurerm_postgresql_flexible_server.pg.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}


# # Linked Service: PostgreSQL
# resource "azurerm_data_factory_linked_service_postgresql" "ls_pg" {
#   name            = "ls_postgres"
#   data_factory_id = azurerm_data_factory.amdarifactory_tf.id

#   # For Flexible Server, ADF typically uses:
#   # Host = <server>.postgres.database.azure.com
#   # Username = <admin_user>@<server_name>
#   # SSL = Require
#   connection_string = join(";", [
#     "Host=${azurerm_postgresql_flexible_server.pg.fqdn}",
#     "Port=5432",
#     "Database=${azurerm_postgresql_flexible_server_database.appdb.name}",
#     "SslMode=Require"
#   ])

#username = "${azurerm_postgresql_flexible_server.pg.administrator_login}@${azurerm_postgresql_flexible_server.pg.name}"
#password = var.pg_admin_password

#   depends_on = [
#     azurerm_postgresql_flexible_server_firewall_rule.allow_all
#   ]
# }



# Dataset that points to my existing PostgreSQL linked service (created manually in ADF)
resource "azurerm_data_factory_dataset_postgresql" "ds_complaints" {
  name            = "ds_complaints_urban"
  data_factory_id = azurerm_data_factory.amdarifactory_tf.id

  # Must match the exact Linked Service name you created in ADF Portal
  linked_service_name = "ls_postgres"

  # Your table created in psql
  table_name = "public.complaints_urban_intelligence"
}


resource "azurerm_data_factory_dataset_parquet" "ds_clean2_parquet_311" {
  name            = "ds_clean2_parquet_311"
  data_factory_id = azurerm_data_factory.amdarifactory_tf.id

  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.amdarilnkdsrvc.name

  azure_blob_storage_location {
    container = "clean2"
    filename  = "311_service_request.parquet"
  }
}