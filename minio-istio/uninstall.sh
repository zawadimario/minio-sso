#!/bin/sh

# Uninstall MinIO
printf "\n"
echo "Deleting MinIO ..."
printf "\n"
kustomize build minio | kubectl delete -f -
sleep 10
printf "\n"

# Uninstall OIDC AuthService
echo "Deleting OIDC AuthService ..."
printf "\n"
kustomize build identity/oidc-authservice | kubectl delete -f -
sleep 10
printf "\n"

# Uninstall Dex IdP and OpenLDAP
echo "Deleting Dex, OpenLDAP ..."
printf "\n"
kustomize build identity/dex-idp | kubectl delete -f -
sleep 10
printf "\n"

# Delete auth namespace
echo "Deleting auth namespace ..."
printf "\n"
kubectl delete ns auth --force
sleep 5
printf "\n"

# Uninstall addons
echo "Deleting Istio Addons ..."
printf "\n"
kubectl delete -f addons
sleep 10
printf "\n"

# Uninstall istio
echo "Deleting Istio ..."
printf "\n"
./bin/istioctl uninstall --purge -y
sleep 5

# Print confirmation message
printf "\n\n"
echo "Uninstalled Successfully... Run the install.sh script to install again!"
printf "\n"