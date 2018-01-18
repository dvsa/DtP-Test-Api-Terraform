# resource "aws_api_gateway_stage" "mock_stage" {
#   count = "${var.mot_DtP_mock_api_enabled}"
#   stage_name = "${var.dtp_api_version}Stage"
#   rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
#   deployment_id = "${aws_api_gateway_deployment.mock_deployment.id}"
# }

resource "aws_api_gateway_deployment" "mock_deployment" {
  count = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
  stage_name = "${var.dtp_api_version}"

  depends_on = ["aws_api_gateway_integration.dtp_post_tests_mock"]
}