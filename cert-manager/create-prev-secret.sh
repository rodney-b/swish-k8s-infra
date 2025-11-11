#!/bin/bash
set -e
set -o posix

kubectl delete secret -n trust-manager previous-swishkube-trust-anchor || true

kubectl get secret -n trust-manager swishkube-trust-anchor -o yaml \
        | sed -e s/swishkube-trust-anchor/previous-swishkube-trust-anchor/ \
        | grep -E -v '^  *(resourceVersion|uid)' \
        | kubectl apply -f -

# FYI: grep -E -v '^  *(resourceVersion|uid)' removes the resourceVersion and uid fields from YAML output to avoid conflicts