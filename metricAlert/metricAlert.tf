resource "azurerm_monitor_metric_alert" "rules" {
  name                = var.alert_name
  resource_group_name = var.resource_group_name
  scopes              = var.alert_scopes
  description         = var.alert_description

  criteria {
    metric_namespace = var.alert_criteria_metric_namespace
    metric_name      = var.alert_criteria_metric_name
    aggregation      = var.alert_criteria_aggregation
    operator         = var.alert_criteria_operator
    threshold        = var.alert_criteria_threshold

    dimension {
      name     = var.alert_criteria_dimension_name
      operator = var.alert_criteria_dimension_operator
      values   = var.alert_criteria_dimension_values
    }
  }

  action {
    action_group_id = var.alert_action_group_id
  }
}