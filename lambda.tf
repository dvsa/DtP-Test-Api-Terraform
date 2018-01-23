resource "aws_lambda_function" "fake_taa_api" {
  count             = "${var.mot_taa_mock_api_enabled}"
  function_name     = "${var.project}-${var.environment}-${var.component}-fake-api"
  handler           = "src/index.handler"
  runtime           = "nodejs6.10"
  s3_bucket         = "${var.bucket_prefix}${var.environment}"
  s3_key            = "${var.lambda_s3_key}"
  role              = "${aws_iam_role.lambda_exec_role.arn}"
  
  tags {
    Name            = "${var.project}-${var.environment}-fake-api"
    Project         = "${var.project}"
    Environment     = "${var.environment}"
  }
}

resource "aws_iam_role" "lambda_exec_role" {
  count               = "${var.mot_taa_mock_api_enabled}"
  name                = "${var.project}-${var.environment}-${var.component}-lambda-exec-role"
  assume_role_policy  = "${data.template_file.lambda_assume_policy.rendered}"
}

resource "aws_lambda_permission" "apigateway_lambda" {
  count         = "${var.mot_taa_mock_api_enabled}"
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.fake_taa_api.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn    = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.taa_mock.id}/*/${aws_api_gateway_method.post_tests_resource.http_method}${aws_api_gateway_resource.tests_resource.path}"
}
