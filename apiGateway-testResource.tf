# /tests
resource "aws_api_gateway_resource" "tests_resource" {
  count       = "${var.mot_DtP_mock_api_enabled}"  
  rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
  parent_id   = "${aws_api_gateway_rest_api.dtp_mock.root_resource_id}"
  path_part   = "tests"
}

resource "aws_api_gateway_request_validator" "post_tests_resource_validator" {
  count                       = "${var.mot_DtP_mock_api_enabled}"  
  rest_api_id                 = "${aws_api_gateway_rest_api.dtp_mock.id}"
  name                        = "${var.aws_region}-post_tests_resource_validator-${var.environment}"
  validate_request_body       = true
  validate_request_parameters = true
}

# POST /tests
resource "aws_api_gateway_method" "post_tests_resource" {
  count         = "${var.mot_DtP_mock_api_enabled}"  
  rest_api_id   = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id   = "${aws_api_gateway_resource.tests_resource.id}"
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = "false"
  request_validator_id = "${aws_api_gateway_request_validator.post_tests_resource_validator.id}"

  request_models = {
    "application/json" = "${aws_api_gateway_model.TestResult.name}"
  }

  request_parameters = {
    "method.request.header.Content-Type" = true,
    "method.request.header.organisation" = true,
    "method.request.header.date" = true,
    "method.request.header.x-api-key" = true
  }
}

resource "aws_api_gateway_integration" "dtp_post_tests_mock" {
  count                   = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id             = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id             = "${aws_api_gateway_resource.tests_resource.id}"
  http_method             = "${aws_api_gateway_method.post_tests_resource.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.fake_dtp_api.arn}/invocations"
  passthrough_behavior    = "NEVER"
  content_handling = "CONVERT_TO_TEXT"

  request_templates = {
    "application/json"    = "${data.template_file.request_integration_mapping.rendered}"
  }
}

resource "aws_api_gateway_method_response" "dtp_post_tests_mock_200" {
  count       = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id = "${aws_api_gateway_resource.tests_resource.id}"
  http_method = "${aws_api_gateway_method.post_tests_resource.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "${aws_api_gateway_model.ProcessingResult.name}"
  }
}

resource "aws_api_gateway_integration_response" "dtp_post_tests_mock_200" {
  count             = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id       = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id       = "${aws_api_gateway_resource.tests_resource.id}"
  http_method       = "${aws_api_gateway_method.post_tests_resource.http_method}"
  status_code       = "${aws_api_gateway_method_response.dtp_post_tests_mock_200.status_code}"
  selection_pattern = ".*success.*"

  response_templates = {
    "application/json" = "${data.template_file.200_response_integration_mapping.rendered}"
  }

  depends_on = ["aws_api_gateway_integration_response.dtp_post_tests_mock_422"]
}

resource "aws_api_gateway_method_response" "dtp_post_tests_mock_422" {
  count       = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id = "${aws_api_gateway_resource.tests_resource.id}"
  http_method = "${aws_api_gateway_method.post_tests_resource.http_method}"
  status_code = "422"
}

resource "aws_api_gateway_integration_response" "dtp_post_tests_mock_422" {
  count             = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id       = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id       = "${aws_api_gateway_resource.tests_resource.id}"
  http_method       = "${aws_api_gateway_method.post_tests_resource.http_method}"
  status_code       = "${aws_api_gateway_method_response.dtp_post_tests_mock_422.status_code}"
  selection_pattern = ".*dataError.*"

  response_templates = {
    "application/json" = "${data.template_file.422_response_integration_mapping.rendered}"
  }

  depends_on = ["aws_api_gateway_integration_response.dtp_post_tests_mock_503"]
}

resource "aws_api_gateway_method_response" "dtp_post_tests_mock_503" {
  count       = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id = "${aws_api_gateway_resource.tests_resource.id}"
  http_method = "${aws_api_gateway_method.post_tests_resource.http_method}"
  status_code = "503"
}

resource "aws_api_gateway_integration_response" "dtp_post_tests_mock_503" {
  count             = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id       = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id       = "${aws_api_gateway_resource.tests_resource.id}"
  http_method       = "${aws_api_gateway_method.post_tests_resource.http_method}"
  status_code       = "${aws_api_gateway_method_response.dtp_post_tests_mock_503.status_code}"
  selection_pattern = ".*serverError.*"

  response_templates = {
    "application/json" = "${data.template_file.503_response_integration_mapping.rendered}"
  }

  depends_on = ["aws_api_gateway_integration_response.dtp_post_tests_mock_500"]
}

resource "aws_api_gateway_method_response" "dtp_post_tests_mock_500" {
  count       = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id = "${aws_api_gateway_resource.tests_resource.id}"
  http_method = "${aws_api_gateway_method.post_tests_resource.http_method}"
  status_code = "500"
}

resource "aws_api_gateway_integration_response" "dtp_post_tests_mock_500" {
  count             = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id       = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id       = "${aws_api_gateway_resource.tests_resource.id}"
  http_method       = "${aws_api_gateway_method.post_tests_resource.http_method}"
  status_code       = "${aws_api_gateway_method_response.dtp_post_tests_mock_500.status_code}"

  response_templates = {
    "application/json" = "${data.template_file.500_response_integration_mapping.rendered}"
  }
  
  depends_on = ["aws_api_gateway_integration.dtp_post_tests_mock"]
}