#!/bin/bash
set -e
set -o posix

helm repo add jetstack https://charts.jetstack.io --force-update 
# Use a separate namespace for the trust-manager to
# minimize the number of actors in the cluster that can modify the trust sources.
helm upgrade trust-manager jetstack/trust-manager \
  --install \
  --namespace trust-manager \
  --create-namespace \
  --wait \
  --values trust-manager/values.yaml

kubectl apply -f trust-manager/rbac.manifest.yaml