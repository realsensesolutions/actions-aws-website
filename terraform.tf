terraform {
  backend "s3" {
    region = "us-east-1"
  }
}

provider "aws" {
  # Set to us-east-1 as this is where resources have to live
  # for the ACM certificate to be attached to CloudFront
  region = "us-east-1"
}
