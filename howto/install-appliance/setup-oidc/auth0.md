(howto-oidc-auth0)=
# Configure Auth0

Auth0 is a flexible, drop-in solution to add authentication services to your applications. Auth0 supports OIDC and can be used to authenticate users in the Anbox Cloud Dashboard. This guide shows you how to set up Auth0 as the login provider for the dashboard.

1. Open a free account on [Auth0.com](https://auth0.com/).

1. After logging into the Auth0 web interface, from the main navigation's *Applications* section, select *Applications > Create application*.
    - Select the type *Single Page Application* and click *Create*.

1. Go to the *Settings* tab of your new application.
    - Scroll to the *Allowed Callback URLs* field in this tab and enter your Anbox Cloud Dashboard address, followed by `/oidc/callback`.
       - Example: `https://example.com:8406/oidc/callback`
       - An IP address can be used instead of a domain name.
       - Remember that `:8406` is the default listening port and it might differ for your setup.
    - In the *Allowed Logout URLs* field, enter your Anbox Cloud Dashboard address.
       - Example: `https://example.com:8406`
    - Enable *Allow Refresh Token Rotation*.
    - Select *Save Changes*.

1. Copy the following values for the preseed YAML configuration:
    - Near the top of the *Settings* tab, locate the *Domain* field, and prefix it with `https://`. This is your issuer URL.
    - From the *Settings* tab, copy the *Client ID*.
    - Select *Applications > APIs* and copy the *API Audience* value.

1. {ref}`Configure the preseed YAML <howto-configure-oidc>` with the issuer URL, client ID, and API audience URL values obtained in the previous steps.
