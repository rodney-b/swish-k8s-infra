# Altinity Clickhouse

This project uses [skaffold](https://skaffold.dev/docs/) to manage the installation lifecycle.

### Altinity ClickHouse Operator

#### Operator Installation
```sh
skaffold deploy -m altinity-clickhouse-operator
```

#### Operator Uninstallation
```sh
skaffold delete -m altinity-clickhouse-operator
```

<br></br>
### Clickhouse Server & Database Installation

#### CHI Installation
```sh
skaffold deploy -m altinity-clickhouse-installation
```

#### CHI Uninstallation
```sh
skaffold delete -m altinity-clickhouse-installation
```

#### CHI Notes

##### ClickHouse Users
This project uses ClickHouse's [password_sha256_hex](https://clickhouse.com/docs/operations/settings/settings-users#user-namepassword)  to save database user passwords, which means passwords need to be sha256 encrypted. These are genereated automatically by the [pre-install.sh](pre-install.sh) script which is executed by skaffold in the deployment process.

##### ClickHouse Server & Database
The Altinity [ClickHouseInstallation](clickhouse-installation.yaml) custom resource, aka. CHI, installs the ClickHouse server and persistent volume for the database.
- Reference: https://docs.altinity.com/altinitykubernetesoperator/kubernetesoperatorguide/clustersettings/

<br></br>
### ClickHouse Client
See the following reference to learn how you can use the ClickHouse client to connect to your database server:
  - https://clickhouse.com/docs/interfaces/cli
  - Note that you can use configuration files to avoid entering arguments in the cli:
    - https://clickhouse.com/docs/interfaces/cli#configuration_files