#!/bin/bash
set -euo pipefail

namespace="swish-analytics"
kubectl config set-context --current --namespace="${namespace}"

kubectl delete secret hyperdx-clickhouse-connections || true