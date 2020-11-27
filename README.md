# TERRAFORM-AZURE-ARO

This is a HashiCorp Terraform root module that spins up [Microsoft Azure Red Hat OpenShift (ARO)](https://www.openshift.com/products/azure-openshift) cluster(s) using Terraform Workspaces.

## PREREQUISITES

* MS Azure account and subscription
* Service and subscription limits (quotas) increase
* MS Azure CLI v`2.15.1`
* HashiCorp Terraform v`0.13.5`
* HashiCorp Terraform AzureRM provider v`2.37.0`
* Red Hat pull secret from [cloud.redhat.com](https://cloud.redhat.com)

## AZURE INITIAL SETUP

```bash
# Authenticate to Azure using the Azure CLI (it redirects you to the default browser on your machine to log in):
az login

# List all available Azure regions and find the one closest to you:
az account list-locations -o table

# Set the default region for Azure CLI:
az config set defaults.location=australiaeast

# If you have multiple Azure subscriptions, specify the relevant subscription ID:
az account set --subscription <SUBSCRIPTION_ID>

# Register the `Microsoft.RedHatOpenShift` resource provider:
az provider register -n Microsoft.RedHatOpenShift --wait

# Register the `Microsoft.Compute` resource provider:
az provider register -n Microsoft.Compute --wait

# Register the `Microsoft.Storage` resource provider:
az provider register -n Microsoft.Storage --wait
```

## TERRAFORM STATE BACKEND INITIALIZATION

```bash
# Run only once! Create Azure storage backend used by Terraform to store the state file(s):
./create_backend.sh
echo "Copy the generated values to backend.tf!"
```

## HOW TO DEPLOY

```bash
# Check the format of the *.tf files:
terraform fmt

# Initialize Terraform:
terraform init

# Create a new nonprod/prod/quay workspace:
terraform workspace new <nonprod,prod,quay>

# See what is Terraform planning to apply:
terraform plan

# Create the resources:
terraform apply -auto-approve
```

## LICENSE

* MIT, [Lucian Maly](https://github.com/luckylittle) for [Red Hat, Inc.](https://redhat.com)
