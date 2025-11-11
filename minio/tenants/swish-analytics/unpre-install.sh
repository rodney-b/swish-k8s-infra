#!/bin/bash
set -euo pipefail
trap 'echo "error on line $LINENO: \`$BASH_COMMAND\` exited with status $?" >&2' ERR

kubectl config set-context --current --namespace=swish-analytics

kubectl delete -f manifest/intermediate-ca.certificate.yaml || true
kubectl delete -f manifest/ca.issuer.yaml || true
kubectl delete -f manifest/swish-analytics-minio.certificate.yaml || true

kubectl delete secret minio-server-ca || true
kubectl delete secret minio-ca-tls || true
kubectl delete secret minio-server-tls || true
kubectl delete secret swish-analytics-user || true

# Operator secret
kubectl delete secret operator-ca-tls-swish-analytics -n minio-operator || true