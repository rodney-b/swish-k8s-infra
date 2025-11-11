#!/bin/bash
set -euo pipefail

namespace="swish-analytics"
kubectl config set-context --current --namespace="${namespace}"

kubectl delete -f manifest/intermediate-ca.certificate.yaml
kubectl delete -f manifest/ca.issuer.yaml
kubectl delete -f manifest/client.certificate.yaml

kubectl delete secret swishkube-fluent-bit-client-cert || true