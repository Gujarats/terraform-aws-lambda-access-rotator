# reader
variable "iam-user-s3-reader" {
    description = "iam user for S3 read access "
    type = "string"
}
variable "policy-s3-reader" {
    description = "policy name for S3 read only"
    type = "string"
}
variable "bucket-arn" {
    description = "bucket arn for iam user to read it"
    type = "string"
}

# role-for-get-access
variable "role-developers-get-credentials" {
    description = "role name for getting the S3 read access for all developers from parameter store"
    type = "string"
}
variable "policy-developers-get-credentials" {
    description = "policy name for getting the S3 read access for all developers from parameter store"
    type = "string"
}
variable "resource-ssm-credentials" {
    description = "arn parameter store key that stored the access & secret keys use * for the last key eg: arn/s3/read/*"
    type = "string"
}
variable "accounts" {
    description = "List of accounts that are granted to assume the role."
    type        = "list"
}

# lambda
variable "region" {
    description = "define which region your AWS account is"
    type = "string"
}
variable "lambda-function-name" {
    description = "lamba function name"
    type = "string"
}
variable "lambda-time-out" {
    description = "time out for lambda before lamda kill it self"
    default = "5"
}
variable "lambda-runtime" {
    description = "which language to run"
    default = "go1.x"
}

# lambda-role
variable "lambda-role-name" {
    description = "lambda required role name"
    type = "string"
}
variable "policy-store-credentials-name" {
    description = "policy name for storing credentials in paramter store"
    type = "string"
}
variable "policy-rotate-keys-name" {
    description = "policy name for rotating iam user credentials "
    type = "string"
}

# iam-artifact-writer
variable "role-ci-writer" {
    description = "role name for CI"
    type = "string"
}
variable "policy-ci-s3-writer" {
    description = "policy name for ci to read & write S3"
    type = "string"
}
variable "ci-accounts" {
    description = "list of accounts to assume role-ci-writer"
    type = "list"
}
