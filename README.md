# Lambda Access rotator 

Terraform module for rotating access key, this module do these : 
1. Create Lambda function which responsible for ratoting the access & secret keys and store it to parameter store
2. IAM Role that have read access to parameter store for getting the access & secret keys
3. IAM user for all developers that has the S3 read only access

## example

```hcl
module "aws_lambda_access_rotator" {
    source = "github.com/traveloka/terraform-aws-lambda-access-rotator"

    #public variable
    product_domain = "bei"
    aws_service = "lambda.amazonaws.com"
    role_identifier ="Keys Rotator"
    region = "ap-southeast-1"
    
    # iam user
    # assuming there are already S3 resource define before this
    s3_bucket_arn ="aws_s3_bucket.single_bucket.arn"


    # role get access to get credentials from parameter store
    resource_ssm_credentials = "arn:aws:ssm:ap_southeast_1:170466898939:parameter/bei/developers/s3read/*"
    accounts = [
        "arn:aws:iam::account1234:root",
        "arn:aws:iam::acount5678:root"
    ]
    
    # lambda
    lambda_time_out = "5"

    #parameter-store
    key_path_access = "/develoepr/s3/read/access" 
    key_path_secret = "/develoepr/s3/read/secret" 
}

```
