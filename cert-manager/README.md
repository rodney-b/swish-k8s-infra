# Cert Manager, Trust Manager, and Cert Manager CSI Driver

This project uses [skaffold](https://skaffold.dev/docs/) to manage the installation lifecycle.

#### Installation
1. To install run `skaffold deploy`.
```sh
skaffold deploy
```

#### Uninstallation
1. Run `skaffold delete`.
```sh
skaffold delete
```

#### Troubleshooting
##### [Namespace Stuck in Terminating State](https://cert-manager.io/docs/installation/helm/#namespace-stuck-in-terminating-state)

If the namespace has been marked for deletion without deleting the cert-manager installation first, the namespace may become stuck in a terminating state. This is typically due to the fact that the APIService resource still exists however the webhook is no longer running so is no longer reachable. To resolve this, ensure you have run the above commands correctly, and if you're still experiencing issues then run:
```sh
kubectl delete apiservice v1beta1.webhook.cert-manager.io
```

#### Notes
Skaffold had issues with the cert-manager installation and it is why it's not being used here. It would hang at the end of the installation. 