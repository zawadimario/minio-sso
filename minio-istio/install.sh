#!/bin/sh

# Install istio
printf "\n"
echo "Installing Istio ..."
printf "\n"
./bin/istioctl install --set profile=default --skip-confirmation -f istio/default.yaml
sleep 20
printf "\n"

# Install addons
echo "Installing Istio addons ..."
printf "\n"
kubectl apply -f addons
sleep 15
printf "\n"

# Install Dex IdP  and OpenLDAP
echo "Creating auth namespace ..."
printf "\n"
kubectl create ns auth
sleep 2
printf "\n"
echo "Deploying Dex and OpenLDAP ..."
printf "\n"
kustomize build identity/dex-idp | kubectl apply -f -
sleep 15
printf "\n"

# Install OIDC AuthService
echo "Deploying OIDC AuthService ..."
printf "\n"
kustomize build identity/oidc-authservice | kubectl apply -f -
sleep 10
printf "\n"

# Install MinIO
echo "Deploying MinIO, and other MinIO istio resources ..."
printf "\n"
kustomize build minio | kubectl apply -f -
sleep 10
printf "\n"

printf "\n\n"
echo "Istalled Successfully... Run the uninstall.sh script to uninstall!"
printf "\n"

# Access MinIO via istio ingress gateway
# k port-forward -n auth svc/dex 5556 &
# kubectl port-forward -n istio-system svc/istio-ingressgateway 8009:80