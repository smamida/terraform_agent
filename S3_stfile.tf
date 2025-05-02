terraform {
  backend "s3" {
    bucket         = "teststatefilebucketfortf"
    key            = "terraform/state/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    #dynamodb_table = "terraform-locks"
  }
}
