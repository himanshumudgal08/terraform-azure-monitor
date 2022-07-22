
# Azure Monitoring Terraform Module

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage]

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

- This terraform module will be used to manage metric alerts with azure monitor
- This project is a part of opstree's ot-azure initiative for terraform modules

## Information

Metric alerts in Azure Monitor provide a way to get notified when one of your metrics crosses a threshold. Metric alerts work on a range of multi-dimensional platform metrics, custom metrics, Application Insights standard and custom metrics. In this article, we will describe how to create, view, and manage metric alert rules through Azure portal and Azure CLI




## Resources Supported
- [Resource Group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
- [Monitor Action Group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group)
- [Monitor Metric Alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert)

## Module Usage
```
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

# action group module

module "action_group" {
  source              = "../actionGroup"
  resource_group_name = azurerm_resource_group.example.name
  # location                = azurerm_resource_group.example.location
  action_group_name       = "sigma1029"
  action_group_short_name = "short messa"
  # alert_name              = "alert1"
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

# metric alert module

module "metric_alert" {
  source                            = "../metricAlert"
  resource_group_name               = azurerm_resource_group.example.name
  location                          = azurerm_resource_group.example.location
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
  tags                              = var.tags
} 

```

## Inputs
Name | Description | Type | Default | Required
-----|-------------|------|---------|:--------:
`resource_group_name` | The name of resource group | string |  | Yes |
`location` | The location of resource group | string |  | Yes |
`action_group_name` | (Required) The name of the Action Group. Changing this forces a new resource to be created | string | | Yes |
`action_group_tags` | A mapping of tags to assign to the resource. | map | | No |
`enabled` | Whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications | bool | true | No |
`arm_role` | List of ARM role receivers | list | | No |
`automation_runbook` | List of automation runbook receivers | list |  | No |
`azure_app_push` | List of azure app push receivers | list | | No |
`azure_function` | List of azure function | list | | Yes |
`emails` | List of email receivers | list |  | Yes |
`itsm` | List of itsm | list |  |  Yes |
`logic_app` | List of logic app | list | | Yes |
`webhooks` | List of webhook receivers | list |  | Yes |
`alert_name` | The name of the Metric Alert. Changing this forces a new resource to be created | string | | Yes |
`alert_scopes` | A set of strings of resource IDs at which the metric criteria should be applied | list | | Yes |
`alert_description` | Description of metric alert description | string | | No |
`alert_criteria_metric_namespace` | One of the metric namespaces to be monitore | string | | Yes |
`alert_criteria_metric_name` | One of the metric names to be monitored | string | | Yes |
`alert_criteria_aggregation` | The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total | string | | Yes |
`alert_criteria_operator` | The criteria operator. Possible values are Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual | string | | Yes |
`alert_criteria_threshold` | The criteria threshold value that activates the alert | number | | Yes |
`alert_criteria_dimension_name` | One of the dimension names | string | | Yes |
`alert_criteria_dimension_operator` | The dimension operator. Possible values are Include, Exclude and StartsWith | string | | Yes |
`alert_criteria_dimension_values` | The list of dimension values | list | |Yes |
`alert_action_group_id` | Action group ID | string | | Yes |




## Outputs

Name | Description
-----|:----------:
`action_group_id` | Id of the action group | 
`azurerm_monitor_action_group_id` | The ID of monitor action group |
`azurerm_monitor_metric_alert_id` | The ID of monitor metric alert |














## Contributors

- [@name](link)

