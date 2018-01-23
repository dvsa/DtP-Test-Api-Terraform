resource "aws_api_gateway_model" "ProcessingResult" {
  count = "${var.mot_taa_mock_api_enabled}"
  rest_api_id  = "${aws_api_gateway_rest_api.taa_mock.id}"
  name         = "ProcessingResult"
  description  = "Data model used to return processing result to api user."
  content_type = "application/json"

  schema = "${data.template_file.processing_result_model.rendered}"
}

resource "aws_api_gateway_model" "TestResult" {
  count = "${var.mot_taa_mock_api_enabled}"
  rest_api_id  = "${aws_api_gateway_rest_api.taa_mock.id}"
  name         = "TestResult"
  description  = "Test result data model required by api."
  content_type = "application/json"

  schema = "${data.template_file.test_result_model.rendered}"
}
