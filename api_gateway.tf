resource "aws_api_gateway_rest_api" "taa_mock" {
  count = "${var.mot_taa_mock_api_enabled}"  
  name  = "${var.project}-${var.environment}-${var.component}"
}

resource "aws_api_gateway_documentation_part" "taa_mock_post" {
  count = "${var.mot_taa_mock_api_enabled}"
  rest_api_id = "${aws_api_gateway_rest_api.taa_mock.id}"
  location {
    type = "METHOD"
    method = "POST"
    path = "/tests"
  }
  properties = "{\"description\":\"Annual Assessment Interface for Awarding bodies\"}"
}