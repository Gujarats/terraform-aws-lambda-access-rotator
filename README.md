# Lambda Access rotator 

Terraform module for rotating access key, this module do these : 
1. Create Lambda function which responsible for rotating the access & secret keys and store it to parameter store
2. IAM Role that have read access to parameter store for getting the access & secret keys
3. IAM user for all developers that has the S3 read only access

## Important Notes

 - You must provide `.zip` which contains the ready execute file for lambda to execute, the name of the  file must be `aws-rotate-keys.zip`
 - the file inside `.zip` file must be `aws-rotate-keys` which contains your code / compiled code binary 
 - using Go as language by default for lambda function you can choose another language if you want to using `lambda_runtime`
 - the `key_path_accesskey` and `key_path_secret` path must have `/` perfix

## Required resource

 - You must provide one or more aws accounts so that the user in those accounts can get the access & secret keys stored in parameter store
 - You must create your own S3 bucket in order to get bucket arn

## example

```hcl

# S3 resource here
resource "aws_s3_bucket" "single_bucket" {
    bucket = "YOUR-BUCKET-NAME"
    versioning {
        enabled = true
    }
}

module "aws_lambda_access_rotator" {
    source = "github.com/traveloka/terraform-aws-lambda-access-rotator"

    #public variable
    product_domain = "YOUR-DOMAIN-NAME"
    region = "ap-southeast-1"
    
    # iam user
    # assuming there are already S3 resource define before this
    s3_bucket_arn ="aws_s3_bucket.single_bucket.arn"


    # provide another aws account to get credentials from parameter store
    accounts = [
        "arn:aws:iam::account1234:root",
        "arn:aws:iam::acount5678:root"
    ]
    
    # lambda
    lambda_time_out = "5"

    # parameter-store
    # the key path must have "/" perfix
    key_path_access = "/develoepr/s3/read/access" 
    key_path_secret = "/develoepr/s3/read/secret" 
}

```
