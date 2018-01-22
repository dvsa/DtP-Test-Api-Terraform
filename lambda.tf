resource "aws_lambda_function" "fake_dtp_api" {
  count             = "${var.mot_DtP_mock_api_enabled}"
  function_name     = "${var.project}_${var.environment}"
  handler           = "src/index.handler"
  runtime           = "nodejs6.10"
  filename          = "${var.dtp_lambda_zip_location}"
  source_code_hash  = "${base64sha256(file("${var.dtp_lambda_zip_location}"))}"
  role              = "${aws_iam_role.lambda_exec_role.arn}"
  
  tags {
    Name            = "${var.project}-${var.environment}-ApiGateway"
    Project         = "${var.project}"
    Environment     = "${var.environment}"
  }
}

resource "aws_iam_role" "lambda_exec_role" {
  count               = "${var.mot_DtP_mock_api_enabled}"
  name                = "lambda-exec-role_${var.project}_${var.environment}"
  assume_role_policy  = "${data.template_file.lambda_assume_policy.rendered}"
}

resource "aws_lambda_permission" "apigateway_lambda" {
  count         = "${var.mot_DtP_mock_api_enabled}"
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.fake_dtp_api.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn    = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.dtp_mock.id}/*/${aws_api_gateway_method.post_tests_resource.http_method}${aws_api_gateway_resource.tests_resource.path}"
}
