# cnp-module-trafficmanager
Terraform Module for creating a Traffic Manager Profile with Endpoints.

## Variables

Names | Type | Required | Description
--- | --- | --- | --- |
`location` | String | Yes | Location of resouce ie UK SOUTH
`env` | String | Yes | CNP Environment such as sandbox

## Usage

```terraform
module "trafficManagerProfile" {
  source              = "git@github.com:hmcts/cnp-module-trafficmanager"
  location            = "UK South"
  env                 = "${var.env}"
}
```