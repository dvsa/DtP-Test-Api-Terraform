resource "aws_api_gateway_rest_api" "dtp_mock" {
  count = "${var.mot_DtP_mock_api_enabled}"  
  name  = "mockDevelopTheProfesionApi-${var.environment}"
}

resource "aws_api_gateway_documentation_part" "dtp_mock_post" {
  count = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
  location {
    type = "METHOD"
    method = "POST"
    path = "/tests"
  }
  properties = "{\"description\":\"Annual Assessment Interface for Awarding bodies\"}"
}