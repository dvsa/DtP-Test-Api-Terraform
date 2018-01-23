resource "aws_api_gateway_deployment" "mock_deployment" {
  count = "${var.mot_taa_mock_api_enabled}"
  rest_api_id = "${aws_api_gateway_rest_api.taa_mock.id}"
  stage_name = "${var.taa_api_version}"

  depends_on = [
    "aws_api_gateway_integration.taa_post_tests_mock",
    "aws_api_gateway_integration_response.taa_post_tests_mock_200",
    "aws_api_gateway_integration_response.taa_post_tests_mock_422",
    "aws_api_gateway_integration_response.taa_post_tests_mock_503",
    "aws_api_gateway_integration_response.taa_post_tests_mock_500",
    "aws_cloudwatch_log_group.api_gateway_log_group"
    ]
}