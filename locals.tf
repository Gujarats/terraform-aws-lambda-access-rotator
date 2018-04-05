resource "random_id" "lambda_role_name" {
  prefix      = "${var.product_domain}-lamba-role-"
  byte_length = 8
}

resource "random_id" "lambda_function_name" {
    prefix = "${var.product_domain}-rotator-keys-"
    byte_length = 8
}

resource "random_id" "iam_user_s3_reader" {
    prefix = "${var.product_domain}-artifact-reader-"
    byte_length = 8
}

resource "random_id" "role_name_get_credentials" {
    prefix = "${var.product_domain}-get-credentials-"
    byte_length = 8
}
