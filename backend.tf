# Copy this file to 'backend.tf' and replace <reponame> with the name of this Azure DevOps git repository
terraform {
  backend "remote" {
    hostname     = "terraform.ahunga.co.nz"
    organization = "vfnz"

    workspaces {
      prefix = "azr-dx-integration-"
    }
  }
}
