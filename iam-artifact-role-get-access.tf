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
  name ="${random_id.role_name_get_credentials.hex}"
  force_detach_policies = true
  assume_role_policy = "${data.aws_iam_policy_document.developers_get_credentials_assume_role_policy.json}"
}

data "aws_iam_policy_document" "get_credentials_parameter_store_policy" {
  statement {
    actions = ["ssm:GetParameter"]
    effect = "Allow" 
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "get_credentials_parameter_store" {
  name = "${var.product_domain}GetCredentialsParameterStore"
  role = "${aws_iam_role.developers_get_credentials.id}"
  policy = "${data.aws_iam_policy_document.get_credentials_parameter_store_policy.json}"
}
