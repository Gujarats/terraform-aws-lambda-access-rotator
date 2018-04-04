resource "aws_iam_user" "developer"{
  name = "${var.iam_user_s3_reader}"
  force_destroy = true
}

resource "aws_iam_user_policy" "developer_policy" {
  name = "${var.policy_s3_reader}"
  user = "${aws_iam_user.developer.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ReadOnlyS3",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:GetBucketLocation",
                "s3:ListBucket"
            ],
            "Resource": [
                "${var.s3_bucket_arn}",
                "${var.s3_bucket_arn}/*"
            ]
        }
    ]
}
EOF
}

