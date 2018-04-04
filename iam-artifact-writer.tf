data "aws_iam_policy_document" "ci-writer-assume-role-policy" {
  statement = {
    actions = ["sts:AssumeRole"]
    effect = "Allow" 
    principals = {
      type        = "AWS"
      identifiers = "${var.ci-users}"
    }
  }
}

resource "aws_iam_role" "ci-writer" {
  description = "role for ci to have write & read access to s3"
  name = "${var.role-ci-writer}"
  force_detach_policies = true
  assume_role_policy = "${data.aws_iam_policy_document.ci-writer-assume-role-policy.json}"
}

resource "aws_iam_policy" "ci-writer-policy" {
  name = "${var.policy-ci-s3-writer}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ReadOnlyS3",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetBucketLocation",
                "s3:ListBucket"
            ],
            "Resource": [
                "${var.bucket-arn}",
                "${var.bucket-arn}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ci-write-attachment" {
    role       = "${aws_iam_role.ci-writer.name}"
    policy_arn = "${aws_iam_policy.ci-writer-policy.arn}"
}
