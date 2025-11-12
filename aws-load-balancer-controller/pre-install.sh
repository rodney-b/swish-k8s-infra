#!/bin/bash
set -e

kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: aws-load-balancer-controller
  namespace: kube-system
EOF