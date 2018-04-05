resource "aws_iam_user" "developer"{
  name = "${random_id.iam_user_s3_reader.hex}"
}

resource "aws_iam_user_policy" "developer_policy" {
  name = "developer-s3-reader-policy"
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

