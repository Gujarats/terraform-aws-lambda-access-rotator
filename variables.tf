#public usage variable
variable "product_domain" {
    description = "define product domain"
    default = ""    
    type = "string"
}
#variable "aws_service" {
#    description = "name of your aws service in this case lambda.amazonaws.com"
#    type = "string"
#}
#variable "role_identifier" {
#    description = "name of your aws service in this case lambda.amazonaws.com"
#    default = "Keys Rotator"
#    type = "string"
#}
variable "region" {
    description = "define which region your AWS account is"
    type = "string"
}

# reader
variable "s3_bucket_arn" {
    description = "bucket arn for iam user to read it"
    type = "string"
}

# iam-artifact-role-for-get-access
variable "accounts" {
    description = "List of accounts that are granted to assume the role."
    type        = "list"
}

# lambda
variable "lambda_time_out" {
    description = "time out for lambda before lamda kill it self"
    default = "5"
}
variable "lambda_runtime" {
    description = "which language to run"
    default = "go1.x"
}

# parameter-store
variable "key_path_access" {
    description = "path to store access key in parameter store"
    default = "developer/s3read/access"
}
variable "key_path_secret" {
    description = "path to store secret key in parameter store"
    default = "developer/s3read/secret"
}
