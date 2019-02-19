# cnp-module-trafficmanager
Terraform Module for creating a Traffic Manager Profile with Endpoints.

## Variables

Names | Type | Required | Description
--- | --- | --- | --- |
`shutter-page_target` | String | Yes | Shutter page target address
`backend_name` | String | Yes | Name of the backend
`backend_pip` | String | Yes | Public ip of the backend
`public_hostname` | String | Yes | The public hostanme to use when accessing app frontend
`product` | String | Yes | The name of your application
`env` | String | Yes | The deployment environment (sandbox, aat, prod etc..)
`common_tags` | Maps | Yes | Common tags
`resource_group` | String | Yes | Name of the resource group

## Usage

```terraform
module "trafficManagerProfile" {
  source                  = "git@github.com:hmcts/cnp-module-trafficmanager"
  shutter-page_target     = "yourname.azurewebsites.net"
  backend_name            = "${local.backend_name}"
  backend_pip             = "${data.null_data_source.waf-pip.outputs["pip"]}"
  public_hostname         = "${var.public_hostname}"
  product                 = "${var.product}"
  env                     = "${var.env}"
  common_tags             = "${var.common_tags}"
  resource_group          = "${azurerm_resource_group.shared_resource_group.name}"
}

```