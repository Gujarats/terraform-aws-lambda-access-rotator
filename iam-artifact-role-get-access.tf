data "aws_iam_policy_document" "developers-get-credentials-assume-role-policy" {
  statement = {
    actions = ["sts:AssumeRole"]
    effect = "Allow" 
    principals = {
      type        = "AWS"
      identifiers = "${var.accounts}"
    }
  }
}

resource "aws_iam_role" "developers-get-credentials" {
  description = "role for another acoount to get iam user which has read access to s3"
  name = "${var.role-developers-get-credentials}"
  force_detach_policies = true
  assume_role_policy = "${data.aws_iam_policy_document.developers-get-credentials-assume-role-policy.json}"
}

resource "aws_iam_policy" "get-credentials-parameter-store" {
    name        = "${var.policy-developers-get-credentials}"
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
            "Resource": "${var.resource-ssm-credentials}"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "developers-get-credentials-attachment" {
    role       = "${aws_iam_role.developers-get-credentials.name}"
    policy_arn = "${aws_iam_policy.get-credentials-parameter-store.arn}"
}

