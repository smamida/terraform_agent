terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-ubix"
    key            = "terraform/state/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    #dynamodb_table = "terraform-locks"
  }
}
