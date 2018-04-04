resource "aws_iam_user" "developer"{
  name = "${var.iam-user-s3-reader}"
  force_destroy = true
}

resource "aws_iam_user_policy" "developer-policy" {
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

