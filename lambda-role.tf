resource "aws_iam_role" "lambda_role" {
  description = "role for lambda function to ratoate access & secret keys"
  name = "${var.lambda_role_name}"
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

# Policy 
resource "aws_iam_policy" "store_credentials_policy" {
    name        = "${var.policy_store_credentials_name}"
    description = "For storing the acces & secret keys to parameter store"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "StoreCredentials",
            "Effect": "Allow",
            "Action": [
                "ssm:PutParameter",
                "ssm:DescribeParameters",
                "ssm:GetParameter"
            ],
            "Resource": "${var.resource_ssm_credentials}"
        }
    ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "role_lambda_attachment1" {
    role       = "${aws_iam_role.lambda_role.name}"
    policy_arn = "${aws_iam_policy.store_credentials_policy.arn}"
}

# Policy 
resource "aws_iam_policy" "rotate_keys_policy" {
    name        = "${var.policy_rotate_keys_name}"
    description = "For rotating the acces & secret keys to specific iam_user"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "RotateKeysForALlIAMusers",
            "Effect": "Allow",
            "Action": [
                "iam:ListAccessKeys",
                "iam:GetAccessKeyLastUsed",
                "iam:DeleteAccessKey",
                "iam:CreateAccessKey",
                "iam:UpdateAccessKey"
            ],
            "Resource": "${aws_iam_user.developer.arn}"
        }
    ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "role_lambda_attachment2" {
    role       = "${aws_iam_role.lambda_role.name}"
    policy_arn = "${aws_iam_policy.rotate_keys_policy.arn}"
}
