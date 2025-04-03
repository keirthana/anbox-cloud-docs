(howto-oidc-ory)=
# How to configure Ory Hydra

Ory Hydra is an easy solution to authenticate users in the Anbox Cloud Dashboard. It supports both local user accounts and social login options, including Google, Facebook, Microsoft, GitHub, Apple and others. This guide shows you how to set up Ory Hydra as the login provider for the dashboard.

1. Create a free account on [Ory.sh/Hydra](https://www.ory.sh/hydra/).

1. After logging into into the Ory Console, navigate to *OAuth 2 > OAuth2 Clients > Create OAuth2 Client*.

1. Select the type *Mobile / SPA* and click *Create*. Enter the details for the client:
   - **Client Name**: Choose a name, such as `anbox-cloud-dashboard-ory-client`.
   - **Scope**: Add the following scopes one by one by entering each and clicking *Add*: `email`, `openid`, and `profile`.
   - **Redirect URIs**: Enter your Anbox Cloud Dashboard address, followed by `/oidc/callback`, then click *Add*.
      - Example: `https://example.com:8406/oidc/callback`
      - An IP address can be used instead of a domain name.
      - Remember that `:8406` is the default listening port and it might differ for your setup.
   - **Post Logout Redirect URIs**: Enter your Anbox Cloud Dashboard address, then click *Add*.
      - Example: `https://example.com:8406`

1. Select *Create Client* on the bottom of the page.

1. On the *OAuth2 Clients* list, find and copy the *ID* for the client you created.

1. In the Ory Console, navigate to *OAuth 2* > *Overview*. Find and copy the value of the *Issuer URL*.

1. {ref}`Configure the preseed YAML <howto-configure-oidc>` with the client ID and issuer URL values obtained in the previous steps.

```{important}
No users exist within ORY by default. New users can use the sign-up link during login. Alternatively, configure Google, Facebook, Microsoft, GitHub, Apple, or another social sign-in provider as described in the [ORY documentation](https://www.ory.sh/docs/kratos/social-signin/overview).
```