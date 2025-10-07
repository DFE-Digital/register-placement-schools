module "domains_infrastructure" {
  source = "./vendor/modules/domains//domains2/infrastructure_v2"
  
  front_door_name     = "${var.azure_resource_prefix}-${var.service_short}-test-fd"
  resource_group_name = "${var.azure_resource_prefix}-${var.service_short}-${var.config_short}-rg"
  
  hosted_zones = {
    for zone_name, zone_config in var.hosted_zone : zone_name => {
      zone_name              = zone_name
      resource_group_name    = lookup(zone_config, "resource_group_name", "${var.azure_resource_prefix}-${var.service_short}-${var.config_short}-rg")
      deploy_default_records = var.deploy_default_records
      caa_record_list        = lookup(zone_config, "caa_records", [])
      txt_records            = lookup(zone_config, "txt_records", {})
    }
  }
  
  azure_enable_monitoring = var.azure_enable_monitoring
  
  tags = merge(
    var.common_tags,
    {
      Service     = var.service_name
      Environment = "Test"
      Module      = "domains2"
    }
  )
}