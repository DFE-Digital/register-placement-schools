variable "hosted_zone" {
  type    = map(any)
  default = {}
}

variable "deploy_default_records" {
  default = false
}

variable "azure_resource_prefix" {
  type        = string
  description = "Azure resource prefix"
}

variable "service_short" {
  type        = string
  description = "Service short name"
}

variable "service_name" {
  type        = string
  description = "Service full name"
}

variable "config_short" {
  type        = string
  description = "Configuration short name"
}

variable "azure_enable_monitoring" {
  default = false
}

variable "common_tags" {
  type    = map(string)
  default = {}
}