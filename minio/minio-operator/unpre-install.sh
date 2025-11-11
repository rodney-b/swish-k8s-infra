#!/bin/bash
set -e
set -o posix

kubectl config set-context --current --namespace=minio-operator

kubectl delete -f manifest/intermediate-ca.yaml
kubectl delete -f manifest/id-issuer.yaml
kubectl delete -f manifest/sts-tls-certificate.yaml

kubectl delete secret operator-ca-tls
kubectl delete secret sts-tls