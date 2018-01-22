variable "count" {}
variable "environment" {}
variable "usage_plan_name" {}
variable "quota_limit" {}
variable "quota_period" {}
variable "throttle_burst_limit" {}
variable "throttle_rate_limit" {}
variable "rest_api_id" {}
variable "stage_name" {}
variable "api_key_value" {}

resource "aws_api_gateway_usage_plan" "usage_plan" {
  count = "${var.count}"
  name  = "${var.usage_plan_name}-${var.environment}"

  api_stages {
    api_id = "${var.rest_api_id}"
    stage  = "${var.stage_name}"
  }

  quota_settings {
    limit  = "${var.quota_limit}"
    period = "${var.quota_period}"
  }

  throttle_settings {
    burst_limit = "${var.throttle_burst_limit}"
    rate_limit  = "${var.throttle_rate_limit}"
  }
}

resource "aws_api_gateway_api_key" "api_key" {
  count = "${var.count}"
  name  = "${var.usage_plan_name}-key-${var.environment}"
  value = "${var.api_key_value}"
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  count         = "${var.count}"
  key_id        = "${aws_api_gateway_api_key.api_key.id}"
  key_type      = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.usage_plan.id}"
}