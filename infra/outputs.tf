output "DtP_mock_url" {
  value = "${aws_api_gateway_deployment.mock_deployment.*.invoke_url}"
}