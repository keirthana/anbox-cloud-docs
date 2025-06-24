(howto-appliance-enable-oidc)=
# Enable custom identity provider

The Anbox Cloud Appliance has support for custom identity providers for authentication through the use of [OpenID Connect](https://openid.net/developers/discover-openid-and-openid-connect/).

Support for a custom identity provider has to be enabled at initialization by using a preseed configuration. See {ref}`ref-appliance-preseed-config` for more details.

Anbox Cloud uses the [authorization code flow](https://openid.net/specs/openid-connect-core-1_0.html#CodeFlowAuth) to obtain an identity token. No access token is requested in this flow because authorization is handled within the Anbox Cloud services.

In order to allow discovery of the necessary endpoints on the identity provider, it must support the [OpenID Connect Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html) protocol.

This section shows you how to configure an [OpenID Connect](https://openid.net/developers/discover-openid-and-openid-connect/) based identity provider for the appliance.

## Preparation

In order to configure [OpenID Connect](https://openid.net/developers/discover-openid-and-openid-connect/) based authentication, you will need the following from your identity provider:

* The issuer URL
* The client ID

To set up your identity provider and retrieve the required values, follow the guide below based on the identity provider you are using:

* {ref}`howto-oidc-auth0`
* {ref}`howto-oidc-keycloak`
* {ref}`howto-oidc-ory`


```{toctree}
:hidden:

Configure Auth0 <auth0>
Configure Keycloak <keycloak>
Configure Ory Hydra <ory>
Configure OIDC Connect <configure-oidc>
```