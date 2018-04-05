# reader
variable "iam_user_s3_reader" {
    description = "iam user for S3 read access "
    type = "string"
}
variable "policy_s3_reader" {
    description = "policy name for S3 read only"
    type = "string"
}
variable "s3_bucket_arn" {
    description = "bucket arn for iam user to read it"
    type = "string"
}

# role-for-get-access
variable "role_developers_get_credentials" {
    description = "role name for getting the S3 read access for all developers from parameter store"
    type = "string"
}
variable "policy_developers_get_credentials" {
    description = "policy name for getting the S3 read access for all developers from parameter store"
    type = "string"
}
variable "resource_ssm_credentials" {
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
variable "lambda_function_name" {
    description = "lamba function name"
    type = "string"
}
variable "lambda_time_out" {
    description = "time out for lambda before lamda kill it self"
    default = "5"
}
variable "lambda_runtime" {
    description = "which language to run"
    default = "go1.x"
}

# lambda-role
variable "lambda_role_name" {
    description = "lambda required role name"
    type = "string"
}
variable "policy_store_credentials_name" {
    description = "policy name for storing credentials in paramter store"
    type = "string"
}
variable "policy_rotate_keys_name" {
    description = "policy name for rotating iam user credentials "
    type = "string"
}
