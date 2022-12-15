# Create a private DNS zone within the resource group

resource "azurerm_private_dns_zone" "private-dns-zone" {
  name                = local.domain_name
  resource_group_name = var.az_resourcegroup_name
  tags                = local.common_tags
}

# Deploy ARO using ARM template

resource "azurerm_template_deployment" "aro-cluster" {
  name                = "openshift-cluster-${local.environment}"
  resource_group_name = var.az_resourcegroup_name

  template_body = file("${path.module}/ARM-openShiftClusters.json")

  parameters = {
    "clientId"                 = var.az_client_id
    "clientSecret"             = var.az_client_secret
    "clusterName"              = "openshift-cluster-${local.environment}"
    "clusterResourceGroupName" = var.az_cluster_resourcegroup_name
    "domain"                   = local.domain_name
    "location"                 = var.location
    "masterSubnetId"           = var.az_subnet_id_controlplane
    "pullSecret"               = var.rh_pull_secret
    "tags"                     = jsonencode(local.common_tags)
    "workerSubnetId"           = var.az_subnet_id_worker
  }

  deployment_mode = "Incremental"
  
  depends_on		= [
    azurerm_role_assignment.vnet_assignment,
    azurerm_role_assignment.rp_assignment,
  ]
  timeouts {
    create = "90m"
  }
}

# The Terraform outputs

output "aro-cluster" {
  value = azurerm_template_deployment.aro-cluster
}

# Use this data source to access the configuration of the AzureRM provider

data "azurerm_client_config" "current" {
}

resource "azurerm_role_assignment" "vnet_assignment" {
  count			= length(var.roles)
  scope			= var.az_vnet_id
  role_definition_name	= var.roles[count.index].role
  principal_id		= var.az_sp_object_id
}

resource "azurerm_role_assignment" "rp_assignment" {
  count			= length(var.roles)
  scope			= var.az_vnet_id
  role_definition_name	= var.roles[count.index].role
  principal_id		= var.az_rp_object_id
}

resource "azuread_application" "redirect-uri" {
  name			= "aroclusterauthcalback"
  reply_urls            = [azurerm_template_deployment.aro-cluster.outputs["oauthCallbackURL"]]

  depends_on = [
    azurerm_template_deployment.aro-cluster
  ]
}

resource "null_resource" "azuread-connect" {
  provisioner "local-exec" {
    command 		= <<EOC
      test "var.ocp_config_enable" = "ENABLED"  && curl ${var.ocp_config_url}
      # TODO: monitor previous step for completion
      # test "var.ocp_clusterpayload_enable" = "ENABLED"  && curl ${var.ocp_clusterpayload_url}
    EOC
    interpreter 	= ["/bin/bash", "-c"]
  }
# resource "null_resource" "azuread-connect" {
#   provisioner "local-exec" {
#     command 		= <<EOC
#       echo "POST-DEPLOY-CONNECT"
#       export ARO_NAME=openshift-cluster-${local.environment}
#       export ARO_RG=${var.az_resourcegroup_name}
#       export CLIENT_ID=${var.az_client_id}
#       export CLIENT_SECRET=${var.az_client_secret}
#       export KUBE_PASSWORD=$(az aro list-credentials -n $ARO_NAME -g $ARO_RG --query kubeadminPassword -o tsv 2> /dev/null)
#       export API_SERVER=$(az aro show -n $ARO_NAME -g $ARO_RG --query apiserverProfile.url -o tsv 2> /dev/null )
#       export SECRET_NAME="openid-client-secret-azuread"
#       oc login $API_SERVER -u kubeadmin -p $KUBE_PASSWORD 2> /dev/null
#       oc delete secret $SECRET_NAME -n openshift-config 2> /dev/null
#       oc create secret generic $SECRET_NAME -n openshift-config --from-literal=clientSecret=$CLIENT_SECRET 2> /dev/null
#       export TENANT_ID=${data.azurerm_client_config.current.tenant_id}
#       echo ./azuread-connect.sh $TENANT_ID $CLIENT_ID $SECRET_NAME
#     EOC
#     interpreter 	= ["/bin/bash", "-c"]
#   }
  
#   provisioner "local-exec" {
#     command 		= <<EOC
#       echo "POST-DEPLOY-SYNC"
#       echo ./azuread-sync.sh
#     EOC
#     interpreter 	= ["/bin/bash", "-c"]
#   }
  
#   provisioner "local-exec" {
#     command 		= <<EOC
#       echo "Access Configured"
#       echo "POST-DEPLOY-CONSOLE"
#       WEB_CONSOLE=$(az aro show -n openshift-cluster-${local.environment} -g ${var.az_resourcegroup_name} --query consoleProfile.url -o tsv)
#       echo "You can accesss the Web Console following this url: $WEB_CONSOLE"
#     EOC
#     interpreter 	= ["/bin/bash", "-c"]
#   }

#   # depends_on = [
#   #   azuread_application.redirect-uri
#   # ]
}