#!/bin/bash
set -euo pipefail

namespace="swish-analytics"
kubectl config set-context --current --namespace="${namespace}"

kubectl delete -f manifest/intermediate-ca.certificate.yaml
kubectl delete -f manifest/ca.issuer.yaml
kubectl delete -f manifest/server.certificate.yaml
kubectl delete -f manifest/rbac.yaml || true

kubectl delete secret otel-collector-clickhouse-users || true
kubectl delete secret swishkube-otel-collector-server-cert || true