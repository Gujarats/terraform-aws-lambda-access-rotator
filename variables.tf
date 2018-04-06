#public usage variable
variable "product_domain" {
    description = "define product domain"
    default = ""    
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
    type = "string"
    default = "5"
}
variable "lambda_runtime" {
    description = "which language to run"
    type = "string"
    default = "go1.x"
}

# parameter-store
variable "key_path_access" {
    description = "path to store access key in parameter store"
    type = "string"
    default = "developer/s3read/access"
}
variable "key_path_secret" {
    description = "path to store secret key in parameter store"
    type = "string"
    default = "developer/s3read/secret"
}

# cloud-watch-event
variable "cloud-watch-cron" {
    description = "10 pm UTC rotate the keys , that would be 5 am in gtm +7"
    default = "cron(0 22 * * ? *)"
    type = "string"
}
