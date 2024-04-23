Anbox Cloud provides images based on the Android Open Source Project (AOSP), an operating system typically used in mobile devices or an Anbox Cloud AAOS image which is based on the Android Automotive OS (AAOS), an infotainment platform used in automobiles. Supported Anbox features differ depending what a given image is based on.

The following table lists some Anbox features and whether they are supported for a given base.

| Feature                                                                                                             | AOSP | AAOS |
|---------------------------------------------------------------------------------------------------------------------|------|------|
| boot-package and boot-activity in [application manifest](https://discourse.ubuntu.com/t/application-manifest/24197) | ✓    |   -   |
| [Install app as system app](https://discourse.ubuntu.com/t/how-to-install-an-apk-as-a-system-app/27086)             | ✓    |   -   |
| [Custom Android ID](https://discourse.ubuntu.com/t/ams-configuration/20872#custom-android-id-10)                    | ✓    |   -   |
| [VHAL HTTP API](https://discourse.ubuntu.com/t/anbox-http-api/17819#h-10vhal-31)                                    | -    |   ✓   |
| [VhalConnector](https://canonical.github.io/anbox-cloud.github.com/latest/anbox-platform-sdk/classanbox_1_1VhalConnector.html) in Platform SDK API                                                                                                                   | -    |   ✓   |
| [Custom images](tbd)                                                                                                | -    |   ✓   |
