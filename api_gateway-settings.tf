resource "aws_api_gateway_method_settings" "post_tests" {
  count = "${var.mot_taa_mock_api_enabled}"
  rest_api_id = "${aws_api_gateway_rest_api.taa_mock.id}"
  stage_name  = "${aws_api_gateway_deployment.mock_deployment.stage_name}"
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
    data_trace_enabled = true
  }
}