# Provided from Terraform Enterprise:
variable "az_tenant_id" {
  description = "Azure tenant ID"
}

variable "az_client_secret" {
  description = "Azure client secret"
}

variable "az_client_id" {
  description = "Azure client ID"
}

variable "az_subscription_id" {
  description = "Azure subscription ID"
}

variable "rh_pull_secret" {
  description = "Red Hat Pull Secret"
}

variable "az_rp_object_id" {
  description = "Object ID of the Resource Provider Service Principal"
}

variable "az_sp_object_id" {
  description = "Object ID of the Service Principal"
}
variable "az_resourcegroup_name" {
  description = "The Resource Group name for virtual networks and subnets"
}

variable "az_subnet_id_controlplane" {
  description = "Control Plane Subnet Id"
}

variable "az_subnet_id_worker" {
  description = "Worker Subnet Id"
}

variable "az_vnet_id" {
  description = "Azure Virtual Network ID"
}
variable "az_authz_admin_group_id" {
  description = "Id of Azure Active Directory based group that contains people who will be allowed to log in as admins to OpenShift"
}

variable "az_cluster_resourcegroup_name" {
  description = "Recource group that will get created and contain OpenShift related sources"
}

variable "ocp_config_enable" {
  description = "This variable controls the execution of the cluster configuration stage. 1 for enabled, 0 for disabled."
}

variable "ocp_config_url" {
  description = "The URL to call to execute cluster configuration"
}

variable "ocp_clusterpayload_enable" {
  description = "This variable controls the execution of the cluster payload deployment stage. 1 for enabled, 0 for disabled."
}

variable "ocp_clusterpayload_url" {
  description = "The URL to call to execute cluster payload deployment"
}


variable "workspace_to_environment_map" {
  type = map
  default = {
    default = "azr-dx-integration-dev"
    nonprod = "azr-dx-integration-dev"
    prod    = "prod"
    quay    = "quay"
  }
}

variable "location" {
  description = "The location where the resource group should be created"
  type        = string
  default     = "australiaeast"
}

# az provider show --namespace Microsoft.RedHatOpenShift --query "id"

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
