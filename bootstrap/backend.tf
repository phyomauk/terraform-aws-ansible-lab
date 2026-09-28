terraform {
  backend "s3" {
    bucket       = "phyomauk-terraform-state-file-us-west-1"
    key          = "aws-ansible-lab/bootstrap/terraform.tfstate"
    region       = "us-west-1"
    use_lockfile = true
  }
}

