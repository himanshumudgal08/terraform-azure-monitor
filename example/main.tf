terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.38.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rgdemo"
  location = "eastus"
}

module "action_group" {
  source                  = "../actionGroup"
  resource_group_name     = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  action_group_name       = "sigma1029"
  action_group_short_name = "short messa"
  alert_name              = "alert1"
  action_group_tags = {
    Name = "env"
  }
  enabled = true
  emails = [
    {
      name                    = "name1",
      email_address           = "himanshu.mudgal@opstree.com",
      use_common_alert_schema = false
    }
  ]
}

module "metric_alert" {
  source                            = "../metricAlert"
  resource_group_name               = azurerm_resource_group.example.name
  alert_name                        = "alert987"
  alert_description                 = "eg. Action will be triggered on All Administrative operations"
  alert_scopes                      = ["/subscriptions/05bf3f89-902a-48d2-80b9-6c4e7f55f107/resourceGroups/demo-rg/providers/Microsoft.Storage/storageAccounts/storagewns02"]
  alert_criteria_metric_namespace   = "Microsoft.Storage/storageAccounts"
  alert_criteria_metric_name        = "Transactions"
  alert_criteria_aggregation        = "Total"
  alert_criteria_operator           = "GreaterThan"
  alert_criteria_threshold          = "50"
  alert_criteria_dimension_name     = "ApiName"
  alert_criteria_dimension_operator = "Include"
  alert_criteria_dimension_values   = ["*"]
  alert_action_group_id             = module.action_group.action_group_id
} 