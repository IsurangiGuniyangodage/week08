terraform {
  backend "azurerm" {
    resource_group_name  = "ishuara-tfstate-rg"
    storage_account_name = "ishuaratfstate268640"
    container_name       = "tfstate"
    key                  = "week08.terraform.tfstate"
    subscription_id      = "b940bd1f-1da6-4cf2-8c47-e5dea9cdbbf2"
  }
}