#!/bin/bash
set -euo pipefail

namespace="swish-analytics"
kubectl config set-context --current --namespace="${namespace}"

basePath=$(dirname "${BASH_SOURCE[0]}")

kubectl delete secret clickhouse-users || true