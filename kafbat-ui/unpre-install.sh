#!/bin/bash
set -e

kubectl config set-context --current --namespace='swish-analytics'

kubectl delete secret kafbat-ui-config || true