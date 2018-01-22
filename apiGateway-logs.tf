resource "aws_api_gateway_account" "global" {
  cloudwatch_role_arn = "${aws_iam_role.cloudwatch.arn}"
}

resource "aws_iam_role" "cloudwatch" {
  name  = "${var.project}_${var.environment}_api_gateway_cloudwatch_global"
  assume_role_policy = "${data.template_file.api_gateway_assume_policy.rendered}"
}

resource "aws_iam_role_policy" "cloudwatch" {
  name = "${var.project}_${var.environment}_logs_creation_policy"
  role = "${aws_iam_role.cloudwatch.id}"

  policy = "${data.template_file.cloudwatch_policy.rendered}"
}

resource "aws_cloudwatch_log_group" "api_gateway_log_group" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.dtp_mock.id}/${var.dtp_api_version}"
  retention_in_days = "${var.logs_retention}"

  tags {
    Name            = "${var.project}-${var.environment}-ApiGateway"
    Project         = "${var.project}"
    Environment     = "${var.environment}"
  }
}