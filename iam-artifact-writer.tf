resource "aws_iam_role" "ci-write" {
  description = "role for ci to have write & read access to s3"
  name = "${var.role-ci-writer}"
  force_detach_policies = true
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.ci-accounts}" 
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF
}

resource "aws_iam_user_policy" "ci-write-policy" {
  name = "${var.policy-s3-reader}"
  user = "${aws_iam_user.developer.name}"

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
    role       = "${aws_iam_role.ci-write.name}"
    policy_arn = "${aws_iam_policy.ci-write-policy.arn}"
}
