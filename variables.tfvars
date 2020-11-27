# `az ad sp show --id 'http://openshift' --query "appId"`
client_id         = ""
# `az ad sp show --id 'http://openshift' --query "objectId"`
client_object_id  = ""
# 'password' field in the output of `az ad sp create-for-rbac --role="Contributor" --name="openshift"`
client_secret     = ""
