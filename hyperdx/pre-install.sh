#!/bin/bash
set -euo pipefail
trap 'echo "error on line $LINENO: \`$BASH_COMMAND\` exited with status $?" >&2' ERR

namespace="swish-analytics"
kubectl create namespace "${namespace}" || true
kubectl config set-context --current --namespace="${namespace}"

chUsersSecret="clickhouse-users"
clickhouseUser=hyperdx
clickhousePassword=$(kubectl get secret ${chUsersSecret} -o jsonpath="{.data.${clickhouseUser}_plain}" | base64 --decode)

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: hyperdx-clickhouse-connections
  namespace: ${namespace}
type: Opaque
stringData:
  DEFAULT_CONNECTIONS: |
    [
      {
        "name": "Cluster ClickHouse",
        "host": "http://clickhouse-swish-analytics.swish-analytics.svc.cluster.local:8123",
        "username": "hyperdx",
        "password": "${clickhousePassword}"
      }
    ]
EOF