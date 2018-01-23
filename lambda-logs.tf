resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.fake_taa_api.function_name}"
  retention_in_days = "${var.logs_retention}"

  tags {
    Name            = "${var.project}-${var.environment}-${var.component}"
    Project         = "${var.project}"
    Environment     = "${var.environment}"
  }
}

resource "aws_iam_role_policy" "enable_cwlogs_policy" {
  name   = "${var.project}-${var.environment}-${var.component}-${aws_lambda_function.fake_taa_api.function_name}-enable-cwlogs"
  role   = "${aws_iam_role.lambda_exec_role.id}"
  policy = "${data.template_file.lambda_enable_cwlogs_policy.rendered}"

  depends_on = ["aws_cloudwatch_log_group.lambda_log_group"]
}