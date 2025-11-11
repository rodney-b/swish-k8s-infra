### Minio Tenant Installation For Swish Analytics

#### Deploy The Helm Release
This project uses [skaffold](https://skaffold.dev/docs/) to manage the installation lifecycle.
  1. To install run `skaffold deploy`:
```sh
skaffold deploy
```

### Uninstallation
1. Run `skaffold delete`.
1. Run the tear-down [unpre-install.sh](unpre-install.sh) script.
```sh
skaffold delete
./unpre-install.sh
```