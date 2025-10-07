variable "environment" {
  type        = string
  description = "Environment name"
}

variable "hosted_zone" {
  type    = map(any)
  default = {}
}

variable "rate_limit" {
  type = object({
    duration_in_minutes = number
    threshold          = number
    action            = string
  })
  default = null
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

variable "cluster_root_domain" {
  type        = string
  description = "Cluster root domain"
  default     = "teacherservices.cloud"
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "endpoint_strategy" {
  type        = string
  description = "Endpoint sharing strategy: shared, per_environment, or per_zone"
  default     = "per_environment"
}

variable "max_domains_per_endpoint" {
  type        = number
  description = "Maximum number of domains per endpoint"
  default     = 10
}