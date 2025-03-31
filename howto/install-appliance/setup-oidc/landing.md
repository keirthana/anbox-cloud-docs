(howto-appliance-enable-oidc)=
# How to enable custom identity provider support

The Anbox Cloud Appliance has support for custom identity providers for authentication through the use of [OpenID Connect](https://openid.net/developers/discover-openid-and-openid-connect/).

Support for a custom identity provider has to be enabled at initialization by using a preseed configuration. See {ref}`ref-appliance-preseed-config` for more details.

Anbox Cloud uses the [authorization code flow](https://openid.net/specs/openid-connect-core-1_0.html#CodeFlowAuth) to obtain an identity token. No access token is requested in this flow because authorization is handled within the Anbox Cloud services.

In order to allow discovery of the necessary endpoints on the identity provider, it must support the [OpenID Connect Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html) protocol.

The following will show you how to configure an [OpenID Connect](https://openid.net/developers/discover-openid-and-openid-connect/) based identity provider for the Anbox Cloud Appliance.

## Preparation

In order to configure [OpenID Connect](https://openid.net/developers/discover-openid-and-openid-connect/) based authentication, you will need the following from your identity provider:

* The issuer URL
* The client ID
* (Optional) The audience URL, required by some providers.

To set up your identity provider and retrieve the required values, follow the guide below based on the identity provider you are using:

* [How to configure Auth0 as the Login Provider for the Anbox Cloud Dashboard](/howto/install-appliance/setup-oidc/auth0.md)
* [How to configure Keycloak as the Login Provider for the Anbox Cloud Dashboard](/howto/install-appliance/setup-oidc/keycloak.md)
* [How to configure Ory Hydra as the Login Provider for the Anbox Cloud Dashboard](/howto/install-appliance/setup-oidc/ory.md)


```{toctree}
:hidden:

Configure Auth0 <auth0>
Configure Keycloak <keycloak>
Configure Ory Hydra <ory>
Configure OIDC Connect <configure-oidc>
```