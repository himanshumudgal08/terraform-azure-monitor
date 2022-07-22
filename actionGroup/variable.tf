## Azure Monitor Action Group Variables
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Action Group instance."
  type        = string
}

variable "action_group_name" {
  description = "(Required) The name of the Action Group. Changing this forces a new resource to be created."
  type        = string
}

variable "action_group_short_name" {
  description = "(Required) The short name of the action group. This will be used in SMS messages."
  type        = string
}

variable "action_group_tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "enabled" {
  description = "(Optional) Whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications."
  type        = bool
}

variable "arm_role" {
  description = "List of ARM role receivers"
  type = list(object({
    name                    = string #(Required) The name of the ARM role receiver.
    role_id                 = string #(Required) The arm role id.
    use_common_alert_schema = bool   #(Optional) Enables or disables the common alert schema.
  }))
}

variable "automation_runbook" {
  description = "List of automation runbook receivers"
  type = list(object({
    name                    = string #(Required) The name of the automation runbook receiver.
    automation_account_id   = string #(Required) The automation account ID which holds this runbook and authenticates to Azure resources.
    runbook_name            = string #(Required) The name for this runbook.
    webhook_resource_id     = string #(Required) The resource id for webhook linked to this runbook.
    is_global_runbook       = bool   #(Required) Indicates whether this instance is global runbook.
    service_uri             = string #(Required) The URI where webhooks should be sent.
    use_common_alert_schema = bool   #(Optional) Enables or disables the common alert schema.
  }))
}

variable "azure_app_push" {
  description = "List of azure app push receivers"
  type = list(object({
    name          = string #(Required) The name of the Azure app push receiver.
    email_address = string #(Required) The email address of the user signed into the mobile app who will receive push notifications from this receiver.
  }))
}

variable "azure_function" {
  description = "List of azure function"
  type = list(object({
    name                     = string #(Required) The name of the Azure Function receiver. 
    function_app_resource_id = string #(Required) The Azure resource ID of the function app.
    function_name            = string #(Required) The function name in the function app.
    http_trigger_url         = string #(Required) The http trigger url where http request sent to.
    use_common_alert_schema  = bool   #(Optional) Enables or disables the common alert schema.
  }))
}

variable "emails" {
  description = "List of email receivers"
  type = list(object({
    name                    = string #(Required) The name of the email receiver. Names must be unique (case-insensitive) across all receivers within an action group.
    email_address           = string #(Required) The email address of this receiver.
    use_common_alert_schema = bool   #(Optional) Enables or disables the common alert schema.
  }))
}

# variable "event_hub" {
#   description = "List of event hub"
#   type = list(object({
#     name                    = string
#     event_hub_id            = string
#     use_common_alert_schema = bool
#   }))
# }

variable "itsm" {
  description = "List of itsm"
  type = list(object({
    name                 = string #(Required) The name of the ITSM receiver.
    workspace_id         = string #(Required) The Azure Log Analytics workspace ID where this connection is defined. Format is <subscription id>|<workspace id>, for example 00000000-0000-0000-0000-000000000000|00000000-0000-0000-0000-000000000000.
    connection_id        = string #(Required) The unique connection identifier of the ITSM connection.
    ticket_configuration = string #(Required) A JSON blob for the configurations of the ITSM action. CreateMultipleWorkItems option will be part of this blob as well.
    region               = string #(Required) The region of the workspace.
  }))
}

variable "logic_app" {
  description = "List of logic app"
  type = list(object({
    name                    = string #(Required) The name of the logic app receiver.
    resource_id             = string #(Required) The Azure resource ID of the logic app.
    callback_url            = string #(Required) The callback url where http request sent to.
    use_common_alert_schema = bool   #(Optional) Enables or disables the common alert schema.
  }))
}

variable "sms" {
  description = "List of sms receivers"
  type = list(object({
    name         = string #(Required) The name of the SMS receiver. Names must be unique (case-insensitive) across all receivers within an action group.
    country_code = number #(Required) The country code of the SMS receiver.
    phone_number = number #(Required) The phone number of the SMS receiver.
  }))
}

variable "voice" {
  description = "List of voice message receivers"
  type = list(object({
    name         = string #(Required) The name of the voice receiver.
    country_code = string #(Required) The country code of the voice receiver.
    phone_number = string #(Required) The phone number of the voice receiver.
  }))
}

variable "webhooks" {
  description = "List of webhook receivers"
  type = list(object({
    name                    = string #(Required) The name of the webhook receiver. Names must be unique (case-insensitive) across all receivers within an action group.
    service_uri             = string #(Required) The URI where webhooks should be sent.
    use_common_alert_schema = bool   #(Optional) Enables or disables the common alert schema.
  }))
}
