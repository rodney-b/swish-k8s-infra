#!/bin/bash
set -euo pipefail
trap 'echo "error on line $LINENO: \`$BASH_COMMAND\` exited with status $?" >&2' ERR

namespace='swish-analytics'
kubectl config set-context --current --namespace="${namespace}"

# secret created by strimzi using the KafkaUser resource
keystorePassword=$(kubectl get secret kafbat-ui -o jsonpath="{.data.user\.password}" | base64 --decode)

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: kafbat-ui-config
  namespace: ${namespace}
type: Opaque
stringData:
  config.yaml: |
    kafka:
      clusters:
        - name: swish-analytics
          bootstrapServers: swish-analytics-kafka-brokers.swish-analytics.svc.cluster.local:9093
          properties:
            security.protocol: SSL
            ssl.truststore.type: PEM
            ssl.truststore.location: /ssl/broker-ca.crt
            ssl.keystore.type: PKCS12
            ssl.keystore.location: /ssl/user.p12
            ssl.keystore.password: ${keystorePassword}
EOF