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
  description = "The location where the resource group should be created"
  type        = string
  default     = "australiaeast"
}

variable "pull-secret" {
  default = {}
}

variable "client_object_id" {
  description = "The Application ID used by the Azure Red Hat OpenShift"
}

variable "client_id" {
  description = "The Application ID used by the Azure Red Hat OpenShift"
}

variable "client_secret" {
  description = "The Application Secret used by the Azure Red Hat OpenShift"
}

# az provider show --namespace Microsoft.RedHatOpenShift --query "id"
variable "rp_object_id" {
  description = "The Resource Provider ID for Azure Red Hat OpenShift"
}

variable "roles" {
  description = "Roles to be assigned to the Principal"
  type        = list(object({ role = string }))
  default = [
    {
      role = "Contributor"
    },
    {
      role = "User Access Administrator"
    }
  ]
}
