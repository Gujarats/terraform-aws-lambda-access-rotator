# Contains local values that are used to increase DRYness of the code.
locals {
  # max bytes of random id to use as unique suffix. 16 hex chars, each byte takes 2 hex chars
  max_byte_length = 8

  # Example value: "ServiceRoleForLambda_example-lambda-794e04d479e1c32b"
  role_name_max_length      = 64
  role_name_format          = "ServiceRoleFor%s_%s-"
  role_name_prefix          = "${format(local.role_name_format, title(element(split(".", var.aws_service), 0)),join("-", split(" ", lower(var.role_identifier))))}"
  role_name_max_byte_length = "${(local.role_name_max_length - length(local.role_name_prefix)) / 2}"
  role_name_byte_length     = "${min(local.max_byte_length, local.role_name_max_byte_length)}"
}

# Provides an IAM role name with random value
resource "random_id" "role_name_lambda" {
  prefix      = "${local.role_name_prefix}"
  byte_length = "${local.role_name_byte_length}"
}

resource "random_id" "lambda_function_name" {
    prefix = "${var.product_domain}-rotator-keys"
    byte_length = 8
}

resource "random_id" "iam_user_s3_reader" {
    prefix = "${var.product_domain}-artifact-reader"
    byte_length = 8
}

resource "random_id" "role_name_get_credentials" {
    prefix = "${var.product_domain}-get-credentials"
    byte_length = 8
}
