# Input variables are parameters for Terraform modules

variable "workspace_to_environment_map" {
  type = map
  default = {
    default = "nonprod"
    nonprod = "nonprod"
    prod    = "prod"
    quay    = "quay"
  }
}

variable "location" {
  description = "The location where the resource group should be created."
  type        = string
  default     = "australiaeast"
}

variable "pull-secret" {
  default = {}
}
