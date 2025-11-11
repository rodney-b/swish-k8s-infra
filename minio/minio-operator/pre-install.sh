#!/bin/bash
set -e
set -o posix

namespace="minio-operator"
kubectl create namespace "${namespace}" || true
kubectl config set-context --current --namespace="${namespace}"

kubectl apply -f manifest/intermediate-ca.yaml
kubectl apply -f manifest/id-issuer.yaml
kubectl apply -f manifest/sts-tls-certificate.yaml