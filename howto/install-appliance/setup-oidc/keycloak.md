(howto-install-appliance-setup-oidc-keycloak)=
# How to configure Keycloak as the Login Provider for the Anbox Cloud Dashboard

Keycloak is a self-hosted open source tool for authentication. Keycloak supports OIDC and can be used to authenticate users. This guide shows you how to set up Ory Hydra as the login provider in the Anbox Cloud Dashboard.

1. Setup Keycloak, for this guide, it is assumed that Keycloak is available over HTTPS.
   - Following their guide on [configuring Keycloak for production](https://www.keycloak.org/server/configuration-production).
   - Alternatively run the development version: Download [Keycloak-25.0.4](https://github.com/keycloak/keycloak/releases/download/25.0.4/keycloak-25.0.4.zip), extract the file and run `bin/kc.sh start-dev`. Open `http://localhost:8080/` and create an admin user with password.

1. Sign in to Keycloak with an admin account. Select the *Keycloak* dropdown in the top left corner of the admin console. Click *Create realm*. Enter a *Realm name* such as `anbox-cloud-dashboard-realm` and click *Create*.

1. Navigate to *Clients > Create client*.
   1. Enter a *Client ID*, such as `anbox-cloud-dashboard-client`. Then click *Next*.

   1. Click *Next*.

   1. In the field for *Valid redirect URIs*, enter your Anbox Cloud Dashboard address, followed by `/oidc/callback`.
      - Example: `https://example.com:8406/oidc/callback`
      - An IP address can be used instead of a domain name.
      - Note `:8406` is the default listening port and it might differ for your setup.

   1. In the field for *Valid post logout redirect URIs*, enter your Anbox Cloud Dashboard address.
      - Example: `https://example.com:8406`

   1. Click *Save*.

1. Navigate to *Users > Create new user*, enter a *Username* and click *Create*.

1. On the user detail page, select *Credentials* and *Set password*. Save the new password.

1. Navigate to *Realm settings > OpenID Endpoint Configuration* and copy the value of the *issuer* key. This is your Issuer URL.

1. [Configure the preseed.yaml](/howto/install-appliance/setup-oidc/configure-oidc.md) with the Client ID and Issuer URL values obtained in the previous steps. 