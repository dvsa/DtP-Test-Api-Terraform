module "ABC_usage_plan" {
  source                = "./modules/usage_plan"
  count                 = "${var.mot_taa_mock_api_enabled}"  
  environment           = "${var.environment}"
  usage_plan_name       = "${var.ABC_usage_plan["organization_name"]}-${var.project}-${var.environment}-${var.component}"
  quota_limit           = "${var.ABC_usage_plan["quota_limit"]}"
  quota_period          = "${var.ABC_usage_plan["quota_period"]}"
  throttle_burst_limit  = "${var.ABC_usage_plan["throttle_burst_limit"]}"
  throttle_rate_limit   = "${var.ABC_usage_plan["throttle_rate_limit"]}"
  api_key_value         = "${var.ABC_usage_plan["api_key_value"]}"
  rest_api_id           = "${aws_api_gateway_rest_api.taa_mock.id}"
  stage_name            = "${aws_api_gateway_deployment.mock_deployment.stage_name}"
}

module "IMI_usage_plan" {
  source                = "./modules/usage_plan"
  count                 = "${var.mot_taa_mock_api_enabled}"  
  environment           = "${var.environment}"
  usage_plan_name       = "${var.IMI_usage_plan["organization_name"]}-${var.project}-${var.environment}-${var.component}"
  quota_limit           = "${var.IMI_usage_plan["quota_limit"]}"
  quota_period          = "${var.IMI_usage_plan["quota_period"]}"
  throttle_burst_limit  = "${var.IMI_usage_plan["throttle_burst_limit"]}"
  throttle_rate_limit   = "${var.IMI_usage_plan["throttle_rate_limit"]}"
  api_key_value         = "${var.IMI_usage_plan["api_key_value"]}"
  rest_api_id           = "${aws_api_gateway_rest_api.taa_mock.id}"
  stage_name            = "${aws_api_gateway_deployment.mock_deployment.stage_name}"
}

module "CandG_usage_plan" {
  source                = "./modules/usage_plan"
  count                 = "${var.mot_taa_mock_api_enabled}"  
  environment           = "${var.environment}"
  usage_plan_name       = "${var.CandG_usage_plan["organization_name"]}-${var.project}-${var.environment}-${var.component}"
  quota_limit           = "${var.CandG_usage_plan["quota_limit"]}"
  quota_period          = "${var.CandG_usage_plan["quota_period"]}"
  throttle_burst_limit  = "${var.CandG_usage_plan["throttle_burst_limit"]}"
  throttle_rate_limit   = "${var.CandG_usage_plan["throttle_rate_limit"]}"
  api_key_value         = "${var.CandG_usage_plan["api_key_value"]}"
  rest_api_id           = "${aws_api_gateway_rest_api.taa_mock.id}"
  stage_name            = "${aws_api_gateway_deployment.mock_deployment.stage_name}"
}

module "Kainos_usage_plan" {
  source                = "./modules/usage_plan"
  count                 = "${var.mot_taa_mock_api_enabled}"  
  environment           = "${var.environment}"
  usage_plan_name       = "${var.Kainos_usage_plan["organization_name"]}-${var.project}-${var.environment}-${var.component}"
  quota_limit           = "${var.Kainos_usage_plan["quota_limit"]}"
  quota_period          = "${var.Kainos_usage_plan["quota_period"]}"
  throttle_burst_limit  = "${var.Kainos_usage_plan["throttle_burst_limit"]}"
  throttle_rate_limit   = "${var.Kainos_usage_plan["throttle_rate_limit"]}"
  api_key_value         = "${var.Kainos_usage_plan["api_key_value"]}"
  rest_api_id           = "${aws_api_gateway_rest_api.taa_mock.id}"
  stage_name            = "${aws_api_gateway_deployment.mock_deployment.stage_name}"
}