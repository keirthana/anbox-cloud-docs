(howto-install-appliance-setup-oidc-configure-oidc)=
# Configure OIDC Connect

It is only possible to configure support for OpenID Connect only when the Anbox Cloud Appliance is being initialized with a preseed (see {ref}`ref-appliance-preseed-config`). The other steps to install the Anbox Cloud Appliance as described in {ref}`tut-installing-appliance` remain the same.

The issuer URL, client ID and optional audience URL are set in the preseed configuration as follows:

```yaml
$ cat preseed.yaml
....
dashboard:
  oidc:
    issuer: https://my.auth.com
    client_id: aff32f32ffwfsdfdsfdsg
    # Only if your identity provider requires it
    audience: https://my.auth.com/api/v2
```

With the preseed configuration you can initiate the initialization process by running:

    sudo anbox-cloud-appliance init --preseed < preseed.yaml

Once the initialization has been completed, you can register a new user by running:

    sudo anbox-cloud-appliance dashboard register <email address>

Once the user has been registered by following the printed URL and authenticated with your identity provider, access is granted to the web UI.

## Related topics

* {ref}`tut-installing-appliance`
* {ref}`howto-use-web-dashboard`