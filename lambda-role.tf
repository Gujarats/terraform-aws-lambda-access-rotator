resource "aws_iam_role" "lambda_role" {
  description = "role for lambda function to ratoate access & secret keys"
  name = "${random_id.role_name_lambda.hex}"
  force_detach_policies = true
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "store_credentials" {
  statement {
    actions = [
        "ssm:PutParameter",
        "ssm:DescribeParameters",
        "ssm:GetParameter"
    ]
    effect = "Allow" 
    resources = ["*"]
    #resources = [
    #    "${var.resource_ssm_credentials}"
    #]
  }
}
resource "aws_iam_role_policy" "store_credentials_policy" {
  name = "${var.product_domain}StoreCredentialsPolicy"
  role = "${aws_iam_role.lambda_role.id}"
  policy = "${data.aws_iam_policy_document.store_credentials.json}"
}

data "aws_iam_policy_document" "rotate_keys" {
  statement {
    actions = [
        "iam:ListAccessKeys",
        "iam:GetAccessKeyLastUsed",
        "iam:DeleteAccessKey",
        "iam:CreateAccessKey",
        "iam:UpdateAccessKey"
    ]
    effect = "Allow" 
    resources = ["*"]
    #resources = [
    #    "${aws_iam_user.developer.arn}"
    #]
  }
}
resource "aws_iam_role_policy" "rotate_keys_policy" {
  name = "${var.product_domain}RotateKeysPolicy"
  role = "${aws_iam_role.lambda_role.id}"
  policy = "${data.aws_iam_policy_document.rotate_keys.json}"
}
