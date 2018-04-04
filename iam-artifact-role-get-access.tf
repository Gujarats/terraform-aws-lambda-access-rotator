data "aws_iam_policy_document" "developers_get_credentials_assume_role_policy" {
  statement = {
    actions = ["sts:AssumeRole"]
    effect = "Allow" 
    principals = {
      type        = "AWS"
      identifiers = "${var.accounts}"
    }
  }
}

resource "aws_iam_role" "developers_get_credentials" {
  description = "role for another acoount to get iam user which has read access to s3"
  name = "${var.role_developers_get_credentials}"
  force_detach_policies = true
  assume_role_policy = "${data.aws_iam_policy_document.developers_get_credentials_assume_role_policy.json}"
}

resource "aws_iam_policy" "get_credentials_parameter_store" {
    name        = "${var.policy_developers_get_credentials}"
    description = "For getting the acces & secret keys from parameter store"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": "${var.resource_ssm_credentials}"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "developers_get_credentials_attachment" {
    role       = "${aws_iam_role.developers_get_credentials.name}"
    policy_arn = "${aws_iam_policy.get_credentials_parameter_store.arn}"
}

