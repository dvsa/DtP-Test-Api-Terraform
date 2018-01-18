provider "aws" {
  region     = "${var.aws_region}"
  profile    = "kainos"
}

##############################################################################
# AWS Lambda
##############################################################################

# resource "aws_lambda_function" "dtp_mock" {
  
# }

# resource "aws_lambda_alias" "dtp_mock" {
#   count = "${var.mot_DtP_mock_api_enabled}"  
#   name             = "${var.environment}"
#   description      = "Alias for ${aws_lambda_function.dtp_mock.function_name}"
#   function_name    = "${aws_lambda_function.dtp_mock.arn}"
#   function_version = "${var.dtp_api_version}"
# }

##############################################################################
# Api Gateway
##############################################################################

resource "aws_api_gateway_rest_api" "dtp_mock" {
  count = "${var.mot_DtP_mock_api_enabled}"  
  name  = "mockDevelopTheProfesionApi-${var.environment}"
}

##############################################################################
# Api Gateway documentation
##############################################################################

resource "aws_api_gateway_documentation_part" "dtp_mock_post" {
  location {
    type = "METHOD"
    method = "POST"
    path = "/tests"
  }
  properties = "{\"description\":\"Annual Assessment Interface for Awarding bodies\"}"
  rest_api_id = "${aws_api_gateway_rest_api.dtp_mock.id}"
}

##############################################################################
# Api Gateway data models
##############################################################################

resource "aws_api_gateway_model" "ProcessingResult" {
  count = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id  = "${aws_api_gateway_rest_api.dtp_mock.id}"
  name         = "ProcessingResult"
  description  = "Data model used to return processing result to api user."
  content_type = "application/json"

  schema = <<EOF
{
  "$schema" : "http://json-schema.org/draft-04/schema#",
  "title" : "Data processing status",
  "type" : "object",
  "minProperties": 1,
  "maxProperties": 1,
  "additionalProperties": false,
  "required" : [ "statusCode" ],
  "properties" : {
    "statusCode" : {
      "description": "Processing result",
      "type" : "string",
      "enum" : [ "OK", "NODVSAID", "NOMATCH", "SYSERR" ]
    }
  }
}
EOF
}

resource "aws_api_gateway_model" "TestResult" {
  count = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id  = "${aws_api_gateway_rest_api.dtp_mock.id}"
  name         = "TestResult"
  description  = "Test result data model required by api."
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title" : "Annual Assessment test result data structure",
  "type": "object",
  "minProperties": 3,
  "maxProperties": 3,
  "additionalProperties": false,
  "properties": {
    "organisation": {
      "type": "string",
      "description": "The source of the data. [ABC, IMI or C&G ]"
    },
    "date": {
      "type": "string",
      "description": "The date the data feed was created in YYYY-MM-DD format"
    },
    "testResult": {
      "type": "object",
      "minProperties": 11,
      "maxProperties": 11,
      "additionalProperties": false,
      "properties": {
        "forename": {
          "type": "string",
          "description": "The testers forename"
        },
        "surname": {
          "type": "string",
          "description": "The testers surname"
        },
        "email": {
          "type": "string",
          "description": "preferably the email address used for the MOT testing service"
        },
        "testDate": {
          "type": "string",
          "description": "The date the assessment was completed YYYY-MM-DD format"
        },
        "certificateNo": {
          "type": "string",
          "description": "The number of the issued certificate"
        },
        "year": {
          "type": "string",
          "description": "YYYY/YYYY e.g. 2017/2018"
        },
        "score": {
          "type": "string",
          "description": "Percentage score"
        },
        "pass": {
          "type": "boolean",
          "description": "true or false"
        },
        "categoryGroup": {
          "type": "string",
          "description": "A or B"
        },
        "dvsaId": {
          "type": "string",
          "description": "Id used to access the MOT system"
        },
        "dob": {
          "type": "string",
          "description": "Date of birth in format YYYY-MM-DD"
        }
      },
      "required": [
        "forename",
        "surname",
        "email",
        "testDate",
        "certificateNo",
        "year",
        "score",
        "pass",
        "categoryGroup",
        "dvsaId",
        "dob"
      ]
    }
  },
  "required": [
    "organisation",
    "date"
  ]
}
EOF
}

##############################################################################
# Api Gateway resources
##############################################################################

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
    "method.request.header.date" = true
  }
}

resource "aws_api_gateway_integration" "dtp_post_tests_mock" {
  count                   = "${var.mot_DtP_mock_api_enabled}"
  rest_api_id             = "${aws_api_gateway_rest_api.dtp_mock.id}"
  resource_id             = "${aws_api_gateway_resource.tests_resource.id}"
  http_method             = "${aws_api_gateway_method.post_tests_resource.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  # uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.dtp_mock.arn}:${aws_lambda_alias.dtp_mock.name}/invocations"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-1:425110442143:function:passthruTest/invocations"
  passthrough_behavior    = "NEVER"

  request_templates = {
    "application/json"    = <<EOF
{
  "personName" : $input.json('$.testResult.forename')
}
EOF
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
    "application/json" = <<EOF
{
  "statusCode": "OK"
}
EOF
  }
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
    "application/json" = <<EOF
#set($payload = $util.parseJson($input.path('$.errorMessage')))
{
    #if($payload.personName.contains("NODVSAID"))
        "statusCode": "NODVSAID"
    #elseif($payload.personName.contains("NOMATCH"))
        "statusCode": "NOMATCH"
    #else
        "statusCode": "SYSERR"
    #end
}
EOF
  }
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
    "application/json" = <<EOF
{
}
EOF
  }
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
    "application/json" = <<EOF
{
  "message": "Internal server error - Incorrect test data"
}
EOF
  }
}
##############################################################################
# Api Gateway deployment
##############################################################################


##############################################################################
# Api Gateway custom domain and path mapping
##############################################################################


##############################################################################
# Api Gateway usage plan
##############################################################################