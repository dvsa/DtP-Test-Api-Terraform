output "taa_mock_url" {
  value = "${aws_api_gateway_deployment.mock_deployment.*.invoke_url}"
}

output "IMI_api_key" {
  value = "${var.IMI_usage_plan["api_key_value"]}"
}

output "ABC_api_key" {
  value = "${var.ABC_usage_plan["api_key_value"]}"
}

output "CandG_api_key" {
  value = "${var.CandG_usage_plan["api_key_value"]}"
}

output "Kainos_api_key" {
  value = "${var.Kainos_usage_plan["api_key_value"]}"
}