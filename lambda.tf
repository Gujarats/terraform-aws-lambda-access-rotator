resource "aws_lambda_function" "lambda-function-rotate-keys" {
  description = "roate the access & secret keys IAM user"
  filename         = "aws-rotate-keys.zip"
  function_name    = "${var.lambda-function-name}"
  role             = "${aws_iam_role.lambda-role.arn}"
  handler          = "aws-rotate-keys"
  source_code_hash = "${base64sha256(file("aws-rotate-keys.zip"))}"
  runtime          = "${var.lambda-runtime}"
  timeout = "${var.lambda-time-out}"
  environment {
    variables = {
      PREFIX_ENV_MINE = "MY_APP"
        
      #Prefix must be the same with above
      #TODO get iam user s3 reader
      MY_APP_USER = "${var.iam-user-s3-reader}"
      MY_APP_REGION = "${var.region}"
    }
  }
}
