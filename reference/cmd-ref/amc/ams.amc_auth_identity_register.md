## ams.amc auth identity register

Register a new user in AMS

### Synopsis

Register a new user to allow access in AMS.

		This command works only when AMS is configured to use OIDC based identities.
 		Use this command to authorize a user to allow them access to AMS. The e-mail
		of the user is checked against the e-mail returned from the configured
		identity provider to validate a user's identitye. This command whitelists
		the identity to access AMS resources.
		

```
ams.amc auth identity register <email> [flags]
```

### Examples

```
$ amc auth register john.doe@example.com
```

### Options

```
  -h, --help   help for register
```

### SEE ALSO

* [ams.amc auth identity](ams.amc_auth_identity.md)	 - Manage authentiation & authorization

