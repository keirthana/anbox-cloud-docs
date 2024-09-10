(ref-api)=
# API reference

All communication between AMS and its clients happen using a RESTful API over HTTP. This API is encapsulated over either TLS (for remote operations) or a Unix socket (for local operations).

## APIs and their structure

Anbox Cloud provides the following APIs:

* AMS HTTP API
* Anbox Cloud HTTP API
* Stream Gateway API
* Anbox Platform SDK API

All these APIs except for the {ref}`anbox-https-api` have an auto-generated specification describing its API endpoints.

```{toctree}
:hidden:

AMS HTTP API<https://canonical.github.io/anbox-cloud.github.com/latest/ams/>
anbox-https-api
Anbox Platform API<https://canonical.github.io/anbox-cloud.github.com/latest/anbox-platform-sdk/>
Stream gateway API<https://canonical.github.io/anbox-cloud.github.com/latest/anbox-stream-gateway/>
```
