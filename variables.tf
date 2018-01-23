variable "project" {
  default = "Develop-The-Profession"
}

variable "component" {
  default = "api-mock"
}

variable "environment" {
  default = "dev"
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "mot_taa_mock_api_enabled" {
  default = true
}

variable "taa_api_version" {
  default = "v1"
}

variable "logs_retention" {
  default = "30"
}

variable "ABC_usage_plan" {
  default = {
    organization_name     = "ABC"
    quota_limit           = 1000
    quota_period          = "DAY"
    throttle_burst_limit  = 5
    throttle_rate_limit   = 5
    api_key_value         = "#CY&#n5fjuI&2CJW7zDChr6R24%Jta"
  }
}

variable "IMI_usage_plan" {
  default = {
    organization_name     = "IMI"
    quota_limit           = 1000
    quota_period          = "DAY"
    throttle_burst_limit  = 5
    throttle_rate_limit   = 5
    api_key_value         = "OA!tTC3@NQTGzx^2e4o#G8d&8OBwei"
  }
}

variable "CandG_usage_plan" {
  default = {
    organization_name     = "CandG"
    quota_limit           = 1000
    quota_period          = "DAY"
    throttle_burst_limit  = 5
    throttle_rate_limit   = 5
    api_key_value         = "534JofRtlK*%B4K6t6%k4SoS##5ZUj"
  }
}

variable "Kainos_usage_plan" {
  default = {
    organization_name     = "Kainos"
    quota_limit           = 1000
    quota_period          = "DAY"
    throttle_burst_limit  = 5
    throttle_rate_limit   = 5
    api_key_value         = "C!vd17aN2IZJ*qnw6LZ!hK8y!06^Sa"
  }
}

variable "bucket_prefix" {
  default = ""
}

variable "lambda_s3_key" {
  default = ""
}