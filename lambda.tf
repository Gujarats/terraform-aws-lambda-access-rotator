resource "aws_lambda_function" "lambda_function_rotate_keys" {
  description = "roate the access & secret keys IAM user"
  filename         = "aws-rotate-keys.zip"
  function_name    = "${var.lambda_function_name}"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "aws-rotate-keys"
  source_code_hash = "${base64sha256(file("aws-rotate-keys.zip"))}"
  runtime          = "${var.lambda_runtime}"
  timeout = "${var.lambda_time_out}"
  environment {
    variables = {
      PREFIX_ENV_MINE = "MY_APP"
        
      #Prefix must be the same with above
      #TODO get iam user s3 reader
      MY_APP_USER = "${var.iam_user_s3_reader}"
      MY_APP_REGION = "${var.region}"
    }
  }
}
