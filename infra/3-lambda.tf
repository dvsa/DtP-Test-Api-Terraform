# resource "aws_lambda_function" "dtp_mock" {
  
# }

# resource "aws_lambda_alias" "dtp_mock" {
#   count = "${var.mot_DtP_mock_api_enabled}"  
#   name             = "${var.environment}"
#   description      = "Alias for ${aws_lambda_function.dtp_mock.function_name}"
#   function_name    = "${aws_lambda_function.dtp_mock.arn}"
#   function_version = "${var.dtp_api_version}"
# }