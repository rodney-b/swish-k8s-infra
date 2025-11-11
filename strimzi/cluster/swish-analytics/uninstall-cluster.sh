#!/bin/bash
set -e

kubectl config set-context --current --namespace=swish-analytics

kubectl delete -f cluster/swish-analytics/user.yaml --all || true
kubectl delete -f cluster/swish-analytics/topic.yaml --all --wait=true || true
kubectl delete -f cluster/swish-analytics/kafka.yaml --all || true
kubectl delete -f cluster/swish-analytics/nodepool.yaml --all || true

kubectl delete -f cluster/swish-analytics/intermediate-ca.certificate.yaml --all || true
kubectl delete -f cluster/swish-analytics/ca.issuer.yaml --all || true
kubectl delete -f cluster/swish-analytics/broker.certificate.yaml --all || true

kubectl delete secret kafka-ca-tls || true
kubectl delete secret kafka-broker-tls || true