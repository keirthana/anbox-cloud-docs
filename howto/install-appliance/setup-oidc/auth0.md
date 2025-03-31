(howto-install-appliance-setup-oidc-auth0)=
# How to configure Auth0 as the Login Provider for the Anbox Cloud Dashboard

Auth0 is a flexible, drop-in solution to add authentication services to your applications. Auth0 supports OIDC and can be used to authenticate users in the Anbox Cloud Dashboard. This guide shows you how to set up Auth0 as the login provider in the Anbox Cloud Dashboard.

1. Open a free account on [Auth0.com](https://auth0.com/).

1. Once logged into the Auth0 web interface, from the main navigation's *Applications* section, select *Applications > Create application*.
    - Select the type *Single Page Application* and click *Create*.

1. Go to the *Settings* tab of your new application.
    - Scroll to the *Allowed Callback URLs* field in this tab and enter your Anbox Cloud Dashboard address, followed by `/oidc/callback`.
       - Example: `https://example.com:8406/oidc/callback`
       - An IP address can be used instead of a domain name.
       - Note `:8406` is the default listening port and it might differ for your setup.
    - In the *Allowed Logout URLs* field, enter your Anbox Cloud Dashboard address.
       - Example: `https://example.com:8406`
    - Enable *Allow Refresh Token Rotation*.
    - Select *Save Changes*.

1. Near the top of the *Settings* tab, locate the *Domain* field. Copy the value and add the `https://` prefix. This is your Issuer URL.

1. From the *Settings* tab and copy the *Client ID*.

1. [Configure the preseed.yaml](/howto/install-appliance/setup-oidc/configure-oidc.md) with the Client ID and Issuer URL values obtained in the previous steps.
