data "aws_iam_policy_document" "ci_writer_assume_role_policy" {
  statement = {
    actions = ["sts:AssumeRole"]
    effect = "Allow" 
    principals = {
      type        = "AWS"
      identifiers = "${var.ci_users}"
    }
  }
}

resource "aws_iam_role" "ci_writer" {
  description = "role for ci to have write & read access to s3"
  name = "${var.role_ci_writer}"
  force_detach_policies = true
  assume_role_policy = "${data.aws_iam_policy_document.ci_writer_assume_role_policy.json}"
}

resource "aws_iam_policy" "ci_writer_policy" {
  name = "${var.policy_ci_s3_writer}"

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
                "${var.s3_bucket_arn}",
                "${var.s3_bucket_arn}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ci_write_attachment" {
    role       = "${aws_iam_role.ci_writer.name}"
    policy_arn = "${aws_iam_policy.ci_writer_policy.arn}"
}
