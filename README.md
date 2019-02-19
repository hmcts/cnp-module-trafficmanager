# cnp-module-trafficmanager
Terraform Module for creating a Traffic Manager Profile with Endpoints.

## Variables

Names | Type | Required | Description
--- | --- | --- | --- |
`product` | String | Yes | The name of your application
`env` | String | Yes | The deployment environment (sandbox, aat, prod etc..)
`common_tags` | Maps | Yes | Common tags
`resource_group` | String | Yes | Name of the resource group
`org_name` | String | Yes | Organization name
`traffic_manager_endpoints` | String | Yes | Traffic Manager endpoints
`endpoints_count` | String | Yes | Number of Traffic Manager endpoint

## Usage

```terraform


locals {
  traffic_manager_endpoints = [
    {
      name        = "shutter-page"
      target      = "yourmaintenance.azurewebsites.net"
      priority    = "1"
      status      = "Disabled"
      host_header = ""
    },
    {
      name        = "${local.backend_name}"
      target      = "${module.waf.public_ip_fqdn}" 
      priority    = "2"
      status      = "Enabled"
      host_header = "${var.public_hostname}" //  This has to be the same hostname used in the listeners of the WAF
    }
  ]
}

module "trafficManagerProfile" {
  source                    = "git@github.com:hmcts/cnp-module-trafficmanager"
  product                   = "${var.product}"
  env                       = "${var.env}"
  common_tags               = "${var.common_tags}"
  resource_group            = "${azurerm_resource_group.shared_resource_group.name}"
  org_name                  = "your_organization_name"
  traffic_manager_endpoints = "${local.traffic_manager_endpoints}"
  endpoints_count           = "2"
}

```