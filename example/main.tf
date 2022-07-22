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

module "res_group" {
  source                  = "git::https://github.com/OT-terraform-azure-modules/azure_resource_group.git"
  resource_group_location = "eastus"
  resource_group_name     = "rgdemo"
  tag_map = {
    Name = "azure_rg"
  }
}

module "action_group" {
  source                  = "../actionGroup"
  resource_group_name     = module.res_group.resource_group_name
  action_group_name       = "sigma1029"
  action_group_short_name = "short messa"
  azure_function = null
  sms = null
  webhooks = null
  arm_role = null
  itsm = null
  automation_runbook = null
  azure_app_push = null
  logic_app = null
  voice = null
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
  resource_group_name               = module.res_group.resource_group_name
  location                          = module.res_group.resource_group_location
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
  tags                              = null
  
} 