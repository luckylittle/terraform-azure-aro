#!/bin/bash

# Generate details for authenticating to Azure using a Service Principal and a Client Secret
az ad sp create-for-rbac --role="Contributor"

# TODO: Map the output to the variables.tfvars
echo -n 'Service principal `clientId` is your `appId`'
echo -n 'Service principal `clientSecret` is the `password`'
