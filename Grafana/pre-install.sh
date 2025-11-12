#!/bin/sh
set -e

kubectl config set-context --current --namespace=swish-analytics

kubectl apply -f manifest/intermediate-ca.certificate.yaml
kubectl apply -f manifest/ca.issuer.yaml

tlsSecretName="swishkube-grafana-ca-tls"
kubectl wait --for=jsonpath='{.metadata.name}'="${tlsSecretName}" --timeout=60s secret/"${tlsSecretName}"

user="swishkubeadmin"
password=$(openssl rand -base64 48)
grafanaAdminSecret="grafana-swishkube-admin-user"
kubectl create secret generic "${grafanaAdminSecret}" --from-literal=user="${user}" --from-literal=password="${password}" || true