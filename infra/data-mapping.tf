data "template_file" "200_response_integration_mapping" {
  template = "${file("${path.module}/templates/mapping/apiGateway_200_response_integration_mapping.json.tpl")}"
}

data "template_file" "422_response_integration_mapping" {
  template = "${file("${path.module}/templates/mapping/apiGateway_422_response_integration_mapping.json.tpl")}"
}

data "template_file" "500_response_integration_mapping" {
  template = "${file("${path.module}/templates/mapping/apiGateway_500_response_integration_mapping.json.tpl")}"
}

data "template_file" "503_response_integration_mapping" {
  template = "${file("${path.module}/templates/mapping/apiGateway_503_response_integration_mapping.json.tpl")}"
}

data "template_file" "request_integration_mapping" {
  template = "${file("${path.module}/templates/mapping/apiGateway_request_integration_mapping.json.tpl")}"
}