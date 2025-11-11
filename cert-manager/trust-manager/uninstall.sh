#!/bin/bash
set -e
set -o posix

helm uninstall trust-manager -n trust-manager --ignore-not-found

kubectl delete -f trust-manager/rbac.manifest.yaml || true