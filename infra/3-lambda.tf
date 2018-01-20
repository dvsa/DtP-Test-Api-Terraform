resource "aws_lambda_function" "fake_dtp_api" {
  count             = "${var.mot_DtP_mock_api_enabled}"
  function_name     = "fake-dtp-api-${var.environment}"
  handler           = "src/index.handler"
  runtime           = "nodejs6.10"
  filename          = "./../app/dist/fakeDtPapi.zip"
  source_code_hash  = "${base64sha256(file("./../app/dist/fakeDtPapi.zip"))}"
  role              = "${aws_iam_role.lambda_exec_role.arn}"
}

resource "aws_iam_role" "lambda_exec_role" {
  count               = "${var.mot_DtP_mock_api_enabled}"
  name                = "lambda-exec-role-${var.environment}"
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_permission" "apigateway_lambda" {
  count         = "${var.mot_DtP_mock_api_enabled}"
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.fake_dtp_api.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.dtp_mock.id}/*/${aws_api_gateway_method.post_tests_resource.http_method}${aws_api_gateway_resource.tests_resource.path}"
}
