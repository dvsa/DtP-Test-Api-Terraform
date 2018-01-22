resource "aws_api_gateway_method_settings" "post_tests" {
  rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
  stage_name  = "${aws_api_gateway_deployment.mock_deployment.stage_name}"
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
    data_trace_enabled = true
  }
}