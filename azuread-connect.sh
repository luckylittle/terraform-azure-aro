#!/bin/bash

export TENANT_ID=$1
export CLIENT_ID=$2
export SECRET_NAME=$3

cat <<EOT | tee oauth-cluster.yaml
apiVersion: config.openshift.io/v1
kind: OAuth
metadata:
  name: cluster
spec:
  identityProviders:
  - name: AAD
    mappingMethod: claim
    type: OpenID
    openID:
      clientID: $CLIENT_ID
      clientSecret:
        name: $SECRET_NAME
      extraScopes:
      - email
      - profile
      extraAuthorizeParameters:
        include_granted_scopes: "true"
      claims:
        preferredUsername:
        - email
        - upn
        name:
        - name
        email:
        - email
      issuer: https://login.microsoftonline.com/$TENANT_ID
EOT

echo "Create OAuth Cluster resource"
oc apply -f oauth-cluster.yaml

echo "Cleanup..."
rm -rf oauth-cluster.yaml