/*
This is used to trigger the lambda function
*/
resource "aws_cloudwatch_event_rule" "schedule_lambda_execution" {
  name        = "${var.product_domain}-lambda-event-rotator-rule"
  description = "schedule lambda execution"
  schedule_expression = "${var.cloud_watch_cron}" 
}

resource "aws_cloudwatch_event_target" "target_schedule_lambda_execution" {
    rule = "${aws_cloudwatch_event_rule.schedule_lambda_execution.name}"
    arn = "${aws_lambda_function.lambda_function_rotate_keys.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_rotator" {
    statement_id = "${var.product_domain}-AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda_function_rotate_keys.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.schedule_lambda_execution.arn}"
}
