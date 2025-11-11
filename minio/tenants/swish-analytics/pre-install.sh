#!/bin/bash
set -euo pipefail
trap 'echo "error on line $LINENO: \`$BASH_COMMAND\` exited with status $?" >&2' ERR

namespace="swish-analytics"
kubectl create namespace "${namespace}" || true
kubectl config set-context --current --namespace="${namespace}"

kubectl apply -f manifest/intermediate-ca.certificate.yaml
kubectl apply -f manifest/ca.issuer.yaml
kubectl apply -f manifest/swish-analytics-minio.certificate.yaml

basePath=$(dirname "${BASH_SOURCE[0]}")
tlsSecretName="minio-ca-tls"
userPassword=$(openssl rand -base64 48)

kubectl wait --for=jsonpath='{.metadata.name}'="${tlsSecretName}" --timeout=60s secret/"${tlsSecretName}"

# CA trust tls secret
clusterCA=$(kubectl get secret "${tlsSecretName}" -o jsonpath="{.data.ca\.crt}" | base64 --decode)

# For the Minio Operator to trust the tenant's CAs
# Ref: https://docs.min.io/community/minio-object-store/operations/cert-manager/cert-manager-tenants.html#trust-the-tenant-s-ca-in-minio-operator
kubectl create secret generic operator-ca-tls-swish-analytics --from-literal=ca.crt="$clusterCA" -n minio-operator

# The chart expects the server ca cert in a key named tls.crt
kubectl create secret generic minio-server-ca --from-literal=tls.crt="$clusterCA"
kubectl create secret generic swish-analytics-user --from-literal=CONSOLE_ACCESS_KEY="swish-user" --from-literal=CONSOLE_SECRET_KEY="$userPassword"