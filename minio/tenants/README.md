### Installation
For operator and tenant installation, see their respective README.md in their folders.

### Minio Client
Create a minio client [alias]() for your tenant.
```sh
# Example of an alias which connects to the `minio` service which has been port forwarded 4443:443
mc alias set name-of-alias 'https://localhost:4443' 'console_access_key_here' 'console_secret_key_here'
 ```

For the [minio client](https://github.com/minio/mc?tab=readme-ov-file#documentation) to be able to connect to clusters, in addition to the setting up the access key and secret, you'll need to configure the certificates. 

Note that the name of the certificate files saved to `~/.mc/certs/` are not optional.

```sh
# Example of setting up certs for the minio client
kubectl get secret minio-server-tls -n swish-analytics -o jsonpath='{.data.tls\.crt}' | base64 --decode > ~/.mc/certs/public.crt
kubectl get secret minio-server-tls -n swish-analytics -o jsonpath='{.data.tls\.key}' | base64 --decode > ~/.mc/certs/private.key
kubectl get secret minio-server-tls -n swish-analytics -o jsonpath='{.data.ca\.crt}' | base64 --decode > ~/.mc/certs/CAs/minio-ca.crt
```
