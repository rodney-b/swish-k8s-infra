#!/bin/bash
set -euo pipefail
trap 'echo "error on line $LINENO: \`$BASH_COMMAND\` exited with status $?" >&2' ERR

namespace="swish-analytics"
kubectl create namespace "${namespace}" || true
kubectl config set-context --current --namespace="${namespace}"

kubectl apply -f manifest/intermediate-ca.certificate.yaml
kubectl apply -f manifest/ca.issuer.yaml
kubectl apply -f manifest/client.certificate.yaml