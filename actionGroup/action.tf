resource "azurerm_monitor_action_group" "main" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name
  enabled = var.enabled
  tags = var.action_group_tags

  dynamic "arm_role_receiver" {
    for_each = var.arm_role
    content {
      name                    = arm_role_receiver.value.name
      role_id                 = arm_role_receiver.value.role_id
      use_common_alert_schema = arm_role_receiver.value.use_common_alert_schema
    }
  }

  dynamic "automation_runbook_receiver" {
    for_each = var.automation_runbook
    content {
      name                    = automation_runbook_receiver.value.name
      automation_account_id   = automation_runbook_receiver.value.automation_account_id
      runbook_name            = automation_runbook_receiver.value.runbook_name
      webhook_resource_id     = automation_runbook_receiver.value.webhook_resource_id
      is_global_runbook       = automation_runbook_receiver.value.is_global_runbook
      service_uri             = automation_runbook_receiver.value.service_uri
      use_common_alert_schema = automation_runbook_receiver.value.use_common_alert_schema
    }
  }

  dynamic "azure_app_push_receiver" {
    for_each = var.azure_app_push
    content {
      name          = azure_app_push_receiver.value.name
      email_address = azure_app_push_receiver.email_address
    }
  }

  dynamic "azure_function_receiver" {
    for_each = var.azure_function
    content {
      name                     = azure_function_receiver.value
      function_app_resource_id = azure_function_receiver.value
      function_name            = azure_function_receiver.value
      http_trigger_url         = azure_function_receiver.value
      use_common_alert_schema  = azure_function_receiver.value
    }
  }

  dynamic "email_receiver" {
    for_each = var.emails
    content {
      name                    = email_receiver.value.name
      email_address           = email_receiver.value.email_address
      use_common_alert_schema = email_receiver.value.use_common_alert_schema
    }
  }

  # dynamic "event_hub_receiver" {
  # for_each = var.event_hub
  #     content {
  #         name                    = event_hub_receiver.value
  #         event_hub_id            = event_hub_receiver.value
  #         use_common_alert_schema = event_hub_receiver.value
  #     }
  # }

  dynamic "itsm_receiver" {
    for_each = var.itsm
    content {
      name                 = itsm_receiver.value
      workspace_id         = itsm_receiver.value
      connection_id        = itsm_receiver.value
      ticket_configuration = itsm_receiver.value
      region               = itsm_receiver.value
    }
  }

  dynamic "logic_app_receiver" {
    for_each = var.logic_app
    content {
      name                    = logic_app_receiver.value
      resource_id             = logic_app_receiver.value
      callback_url            = logic_app_receiver.value
      use_common_alert_schema = logic_app_receiver.value
    }
  }

  dynamic "sms_receiver" {
    for_each = var.sms
    content {
      name         = sms_receiver.value
      country_code = sms_receiver.value
      phone_number = sms_receiver.value
    }
  }

  dynamic "voice_receiver" {
    for_each = var.voice
    content {
      name         = voice_receiver.value
      country_code = voice_receiver.value
      phone_number = voice_receiver.value
    }
  }

  dynamic "webhook_receiver" {
    for_each = var.webhooks
    content {
      name                    = webhook_receiver.value.name
      service_uri             = webhook_receiver.value.service_uri
      use_common_alert_schema = webhook_receiver.value.use_common_alert_schema
    }
  }
}