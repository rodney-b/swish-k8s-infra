#!/bin/sh
set -e

kubectl config set-context --current --namespace=swish-analytics

kubectl delete -f manifest/intermediate-ca.certificate.yaml || true
kubectl delete -f manifest/ca.issuer.yaml || true
kubectl delete secret swishkube-grafana-ca-tls || true
kubectl delete secret grafana-swishkube-admin-user || true