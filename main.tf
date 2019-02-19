locals {
  traffic_manager_endpoints = [
    {
      name        = "shutter-page"
      target      = "${var.shutter-page_target}"
      priority    = "1"
      status      = "Disabled"
      host_header = ""
    },
    {
      name        = "${var.backend_name}"
      target      = "${var.backend_pip}"
      priority    = "2"
      status      = "Enabled"
      host_header = "${var.public_hostname}" // // This has to be the same hostname used in the listeners of the WAF
    }
  ]
}

data "template_file" "endpoints" {
  template = "${file("${path.module}/templates/traffic-manager-endpoint.tpl")}"
  count    = "2"

  vars {
    name        = "${lookup(local.traffic_manager_endpoints[count.index], "name")}"
    target      = "${lookup(local.traffic_manager_endpoints[count.index], "target")}"
    priority    = "${lookup(local.traffic_manager_endpoints[count.index], "priority")}"
    status      = "${lookup(local.traffic_manager_endpoints[count.index], "status")}"
    host_header = "${lookup(local.traffic_manager_endpoints[count.index], "host_header")}"
  }
}

data "template_file" "traffic_manager_parameters" {
  template = "${file("${path.module}/templates/traffic-manager-parameters.tpl")}"

  vars {
    org_name  = "${var.org_name}"
    name      = "${var.product}-${var.env}"
    team_name = "${var.common_tags["Team Name"]}"
    endpoints = "${join(",", data.template_file.endpoints.*.rendered)}"
  }
}

data "template_file" "traffic_manager_template" {
  template = "${file("${path.module}/templates/traffic-manager.json")}"
}

resource "azurerm_template_deployment" "traffic_manager" {
  template_body       = "${data.template_file.traffic_manager_template.rendered}"
  name                = "${var.product}-${var.env}-tm"
  resource_group_name = "${var.resource_group}"
  deployment_mode     = "Incremental"
  parameters_body     = "${data.template_file.traffic_manager_parameters.rendered}"
}
