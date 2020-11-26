# Local values are like a function's temporary local variables

locals {
  environment = lookup(var.workspace_to_environment_map, terraform.workspace)
}

locals {
  common_tags = {
    owner   = "lmaly"
    service = "openshift"
    env     = local.environment
  }
}

locals {
  domain_name = "redhat-vodafone-${local.environment}.com"
}
