variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
  default     = "rg-alpha"
}

variable "region" {
  description = "The Azure Region in which to create resource."
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default = {
    Name = "env"
  }
}