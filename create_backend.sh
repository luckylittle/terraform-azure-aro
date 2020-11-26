#!/bin/bash

echo "This only needs to be run once! It creates storage account in Azure, which is used by Terraform to store the tfstate."

CUSTOMER=vodafone
RESOURCE_GROUP_NAME=${CUSTOMER}-tfstate
# Storage account must be unique!
STORAGE_ACCOUNT_NAME=${CUSTOMER}tfstate$RANDOM
CONTAINER_NAME=tfstate

# Create a resource group
az group create --name ${RESOURCE_GROUP_NAME} --location "Australia East"
# Create a storage account
az storage account create --resource-group ${RESOURCE_GROUP_NAME} --name ${STORAGE_ACCOUNT_NAME} --sku Standard_LRS --encryption-services blob
# Get a storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group ${RESOURCE_GROUP_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --query [0].value -o tsv)
# Create a blob container
az storage container create --name ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT_NAME} --account-key ${ACCOUNT_KEY}

echo "Put these values in the backend.tf:"
echo "resource_group_name: ${RESOURCE_GROUP_NAME}"
echo "storage_account_name: ${STORAGE_ACCOUNT_NAME}"
echo "container_name: ${CONTAINER_NAME}"
echo "key: ${ACCOUNT_KEY}"
