data "template_file" "processing_result_model" {
  template = "${file("${path.module}/templates/data_model/processingResult_data_model.json.tpl")}"
}

data "template_file" "test_result_model" {
  template = "${file("${path.module}/templates/data_model/testResult_data_model.json.tpl")}"
}