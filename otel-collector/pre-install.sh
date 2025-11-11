#!/bin/bash
set -euo pipefail
trap 'echo "error on line $LINENO: \`$BASH_COMMAND\` exited with status $?" >&2' ERR

namespace="swish-analytics"
kubectl create namespace "${namespace}" || true
kubectl config set-context --current --namespace="${namespace}"

kubectl apply -f manifest/intermediate-ca.certificate.yaml
kubectl apply -f manifest/ca.issuer.yaml
kubectl apply -f manifest/server.certificate.yaml

chUsersSecret="clickhouse-users"
clickhouseUser=otel_exporter
clickhousePassword=$(kubectl get secret ${chUsersSecret} -n swish-analytics -o jsonpath="{.data.${clickhouseUser}_plain}" | base64 --decode)

otelSecretName=otel-collector-clickhouse-users
kubectl create secret generic $otelSecretName --from-literal=CLICKHOUSE_USERNAME="${clickhouseUser}" --from-literal=CLICKHOUSE_PASSWORD="${clickhousePassword}" || true

kubectl apply -f manifest/rbac.yaml