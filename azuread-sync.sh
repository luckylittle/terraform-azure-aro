#!/bin/bash

echo "Creating APP_ARO_ClusterAdmins Group..."
oc adm groups new APP_ARO_ClusterAdmins

echo "Synchronizing APP_ARO_ClusterAdmins Group..."
oc adm groups add-users APP_ARO_ClusterAdmins $(az ad group member list --group 'GRP DX Partner - Red Hat' --query '[].mail' -o tsv)

echo "Assigning Permissions..."
oc adm policy add-cluster-role-to-group cluster-admin APP_ARO_ClusterAdmins

echo "Removing Kuberadmin virtual user"
oc delete secrets kubeadmin -n kube-system