# Swish Demo K8s Infra

This repository contains the configuration external applications that compose the Kubernetes cluster infrastructure to allow the custom producer and consumer applications to stream the data-sets.

The intention was to make the installation process simple. Each tool contains a README, although many of them simply instruct to run `skaffold deploy` to install and `skaffold delete` to uninstall.

### Standalone Manifests
The [manifest](manifest) directory contains standalone kubernetes manifests that should be applied before installing the other tools. The gateway api specifically should be applied with the `--server-side` flag accoding to the [documentation](https://gateway-api.sigs.k8s.io/guides/#install-standard-channel).
```sh
kubectl apply --server-side -f manifest/gateway-api-standard-install.yaml
```

### References
1. [Skaffold 2.0 Documentation](https://skaffold.dev/docs/)
2. [Deploy the AWS Gateway API Controller on Amazon EKS](https://www.gateway-api-controller.eks.aws.dev/dev/guides/deploy/)