data "template_file" "api_gateway_assume_policy" {
  template = "${file("${path.module}/templates/policy/api_gateway_assume_policy.json.tpl")}"
}

data "template_file" "cloudwatch_policy" {
  template = "${file("${path.module}/templates/policy/cloudwatch_policy.json.tpl")}"
}

data "template_file" "lambda_assume_policy" {
  template = "${file("${path.module}/templates/policy/lambda_assume_policy.json.tpl")}"
}

data "template_file" "lambda_enable_cwlogs_policy" {
  template = "${file("${path.module}/templates/policy/lambda_enable_cwlogs_policy.json.tpl")}"
  vars {
    aws_region = "${var.aws_region}",
    account_id = "${data.aws_caller_identity.current.account_id}",
    lambda_function = "${aws_lambda_function.fake_taa_api.arn}"
  }
}