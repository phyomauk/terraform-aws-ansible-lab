terraform {
  backend "s3" {
    bucket       = "phyomauk-terraform-state-file-us-west-1"
    key          = "aws-ansible-lab/infra/terraform.tfstate"
    region       = "us-west-1"
    use_lockfile = true
  }
}