## Resource Group Variables
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Metric Alert instance."
}

variable "location" {
  description = "The Azure Region in which to create resource."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
}


## Metric Alert Variables
variable "alert_name" {
  type        = string
  description = "(Required) The name of the Metric Alert. Changing this forces a new resource to be created."
}

variable "alert_scopes" {
  type        = list(string)
  description = "(Required) A set of strings of resource IDs at which the metric criteria should be applied."
}

variable "alert_description" {
  type        = string
  description = "(Optional) Description of metric alert description"
}

variable "alert_criteria_metric_namespace" {
  type        = string
  description = "(Required) One of the metric namespaces to be monitored."
}

variable "alert_criteria_metric_name" {
  type        = string
  description = "(Required) One of the metric names to be monitored."
}

variable "alert_criteria_aggregation" {
  type        = string
  description = "(Required) The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total."
}

variable "alert_criteria_operator" {
  type        = string
  description = "(Required) The criteria operator. Possible values are Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual."
}

variable "alert_criteria_threshold" {
  type        = number
  description = "(Required) The criteria threshold value that activates the alert."
}

variable "alert_criteria_dimension_name" {
  type        = string
  description = "(Required) One of the dimension names."
}

variable "alert_criteria_dimension_operator" {
  type        = string
  description = "(Required) The dimension operator. Possible values are Include, Exclude and StartsWith."

}

variable "alert_criteria_dimension_values" {
  type        = list(any)
  description = "(Required) The list of dimension values."
}

variable "alert_action_group_id" {
  type        = string
  description = "Action Group ID"
}
