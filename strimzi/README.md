# Strimzi

This project uses [skaffold](https://skaffold.dev/docs/) to manage the installation lifecycle.

### Strimzi Cluster Operator

#### Operator Installation
```sh
skaffold deploy -m operator
```

#### Operator Uninstallation
```sh
skaffold delete -m operator
```

### Strimzi Kafka Cluster

#### Cluster Installation
```sh
./cluster-install.sh
```

#### Cluster Uninstallation
```sh
./cluster-uninstall.sh
```