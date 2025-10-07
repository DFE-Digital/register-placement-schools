module "domains" {
  source = "./vendor/modules/domains//domains2/environment_domains_v2"
  
  environment             = var.environment
  front_door_profile_name = "${var.azure_resource_prefix}-${var.service_short}-test-fd"
  resource_group_name     = "${var.azure_resource_prefix}-${var.service_short}-${var.config_short}-rg"
  
  endpoint_configuration = {
    strategy                 = var.endpoint_strategy
    max_domains_per_endpoint = var.max_domains_per_endpoint
  }
  
  domains = [
    for zone_name, zone_config in var.hosted_zone : 
    for domain in lookup(zone_config, "domains", ["apex"]) : {
      name                  = "${domain}-${var.environment}"
      zone                  = zone_name
      zone_resource_group   = lookup(zone_config, "resource_group_name", "${var.azure_resource_prefix}-${var.service_short}-${var.config_short}-rg")
      environment           = var.environment
      origin_hostname       = lookup(zone_config, "origin_hostname", "${var.service_name}-${var.environment}.${var.cluster_root_domain}")
      patterns_to_match     = ["/*"]
      enable_caching        = lookup(zone_config, "enable_caching", true)
      subdomain            = domain == "apex" ? null : domain
      health_probe_path    = lookup(zone_config, "health_probe_path", "/")
      health_probe_interval = lookup(zone_config, "health_probe_interval", 30)
      health_probe_timeout  = lookup(zone_config, "health_probe_timeout", 120)
    }
  ]
  
  rate_limit_rules = var.rate_limit != null ? {
    for zone_name, zone_config in var.hosted_zone : 
    "rate-limit-${zone_name}" => {
      domain              = zone_name
      duration_in_minutes = var.rate_limit.duration_in_minutes
      threshold           = var.rate_limit.threshold
      action              = var.rate_limit.action
    }
  } : {}
  
  tags = merge(
    var.common_tags,
    {
      Service     = var.service_name
      Environment = var.environment
      Module      = "domains2"
    }
  )
}