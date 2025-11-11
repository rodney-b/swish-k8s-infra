### Minio Operator Installation 

#### Deploy The Helm Release
This project uses [skaffold](https://skaffold.dev/docs/) to manage the installation lifecycle.
  1. To install run `skaffold deploy`:
```sh
skaffold deploy
```
<br></br>

### Uninstallation
1. Run `skaffold delete`.
1. Delete certificate infrastructure.
```sh
skaffold delete
./del-certificates.sh
```