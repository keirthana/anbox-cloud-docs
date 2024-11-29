(howto-replace-anbox-vhal)=
# Customise the Anbox VHAL

*since 1.22.0*

```{note}
Replacing the Anbox VHAL is only supported on {ref}`AAOS images <ref-provided-images>`.
The Anbox Cloud dashboard does not support custom VHAL implementations.
```

This document will guide through the process of replacing the Anbox Cloud VHAL
implementation with your own implementation placed in the
[ODM partition](https://source.android.com/docs/core/architecture/partitions/odm-partitions)
using {ref}`exp-addons`.

## Prerequisites

Your custom VHAL implementation must provide an
[HIDL VHAL interface](https://source.android.com/docs/automotive/vhal/hidl-vhal-interface)
and be built against VNDK 34.

If your VHAL implementation requires additional libraries, they must also be
bundled with the addon and copied in the ODM partition.

## Create the addon

This addon will be tasked with the following:

1. Copying the VHAL binary to `/odm/bin/hw`.
1. Copying an
<!-- wokeignore:rule=master -->
[init.rc file](https://android.googlesource.com/platform/system/core/+/master/init/README.md)
for your VHAL service to `/odm/etc/init`.
1. Disabling the Anbox Cloud VHAL by setting the `ro.anbox.automotive.vhal`
property to `odm`. This will be done by writing that system property to the
`/odm/etc/build.prop` file.

In the following example, we will name our addon `custom-vhal`.
To override the VHAL implementation, we will use a
{ref}`pre-start hook <ref-hooks>` which is executed
before Android gets started.

The directory layout for the addon is strict and must be:

```
custom-vhal/
├── hooks
│   └── pre-start
├── manifest.yaml
├── vhal
└── vhal.rc
```

As mentioned in the prerequisites, any additional libraries must also be bundled with the addon.

`vhal` is your custom VHAL implementation.

`vhal.rc` is an [init.rc file](https://android.googlesource.com/platform/system/core/+/main/init/README.md) for your VHAL service, such as:

```
service custom-vhal /odm/bin/hw/vhal
    class hal
    user vehicle_network
    group system inet
    disabled

on property:ro.anbox.automotive.vhal=odm
    start custom-vhal
```

`hooks/pre-start` must be an executable file which will handle the tasks
outlined at the beginning of this section, such as the following bash script:

```bash
#!/bin/bash -x
#
# Copyright 2024 Canonical Ltd.  All rights reserved.
#

ANDROID_ODM_DIR="${ANBOX_DIR}/android-odm"

if [ "${INSTANCE_TYPE}" != base ]; then
    exit 0
fi

# Ensure all needed directories are created
mkdir -p "${ANDROID_ODM_DIR}/etc/init"
mkdir -p "${ANDROID_ODM_DIR}/bin/hw"

# Copy the custom VHAL and the associated init file in /odm
cp "${ADDON_DIR}/vhal" "${ANDROID_ODM_DIR}/bin/hw/"
cp "${ADDON_DIR}/vhal.rc" "${ANDROID_ODM_DIR}/etc/init/"

# Set the ro.anbox.anbox.vhal system property to 'odm'
echo "ro.anbox.automotive.vhal=odm" >> "${ANDROID_ODM_DIR}/etc/build.prop"
```

The {ref}`ref-addon-manifest` file
contains metadata:

```yaml
name: custom-vhal
description: |
  Addon replacing the Anbox Cloud VHAL with a custom implementation.
```

Once everything is in place, you can add the addon to your Anbox Cloud instance,
with:

```bash
amc addon add custom-vhal ./custom-vhal
```

Please note that due to Snap strict confinement, the addon directory
(`custom-vhal` here) must be located in the home directory of the user executing
the `amc` command.

## Use the addon

The newly added `custom-vhal` addon must now be enabled to be used with
Anbox Cloud applications.

If you plan to always override the Anbox Cloud VHAL implementation in all
applications, you can
enable the addon globally (see {ref}`howto-enable-addons-globally`):

```bash
amc config set application.addons custom-vhal
```

Otherwise, add it to your {ref}`ref-application-manifest`:

```yaml
name: my-app
addons:
  - custom-vhal
```

## Integrate Anbox VHAL interface

To use and integrate the [Anbox VHAL interface](https://github.com/canonical/vendor_canonical_interfaces/tree/main/vehicle) into a VHAL implementation, the implementation must be built against Android 14. Before proceeding, ensure you have downloaded the Android 14 source. If you haven't done so yet, please follow the [official documentation](https://source.android.com/docs/setup/download) to set it up.

1. Add a new remote definition named `github` to `.repo/manifests/manifest.xml` file.

       <remote name="aosp"
          fetch=".."
          review="https://android-review.googlesource.com/" />

       <remote name="github"
          fetch="https://github.com/canonical/" />

1. Add a new project named `vendor_canonical_interfaces` to the newly added remote and set it to use the `main` branch.

       <project path="vendor/canonical/interfaces"
                name="vendor_canonical_interfaces"
                remote="github"
                revision="main" />

1. Sync the project with the remote.

        repo sync vendor_canonical_interfaces

1. In the VHAL implementation, create a VHAL manifest fragment named `vendor.canonical.interfaces.vehicle@1.0.xml`.

       <manifest version="1.0" type="device">
           <hal format="hidl">
               <name>vendor.canonical.interfaces.vehicle</name>
               <transport>hwbinder</transport>
               <fqname>@1.0::IVehicle/default</fqname>
           </hal>
       </manifest>

   Place the VHAL manifest fragment file in the same folder as the `Android.bp` file that declares the VHAL service, and include the Anbox VHAL manifest fragment in the VHAL service declaration within the `Android.bp` file. Additionally, add the HIDL module as a shared library that the VHAL service links to in the `Android.bp` file.


       cc_binary {
           name: "vendor.<company>.vehicle@<version>-service",
           vintf_fragments: [
               ...
               "vendor.canonical.interfaces.vehicle@1.0.xml",
           ],
           shared_libs: [
               ...
               "vendor.canonical.interfaces.vehicle@1.0",
           ],
           ...
       }

1. Take the [example](https://github.com/canonical/vendor_canonical_interfaces/tree/main/vehicle/1.0/default) as a reference, which implements the `IVehicle` interface.

        Return<void> VHalService::get(
            const VehiclePropValue& requestedPropValue, IVehicle::get_cb _hidl_cb) {
          uid_t uid = android::IPCThreadState::self()->getCallingUid();
          if (uid != AID_VEHICLE_NETWORK) {
            _hidl_cb(StatusCode::ACCESS_DENIED, kEmptyValue);
            return Void();
          }

          // NOTE: a VHAL implementation must allow access to non-readable vehicle properties.
          return Void();
        }

        Return<StatusCode> VHalService::set(const VehiclePropValue& value) {
          uid_t uid = android::IPCThreadState::self()->getCallingUid();
          if (uid != AID_VEHICLE_NETWORK)
            return StatusCode::ACCESS_DENIED;

          // NOTE: a VHAL implementation must allow modification of non-writable vehicle properties.
          return StatusCode::NOT_AVAILABLE;
        }

   Please note that each function must implement a security mechanism to restrict access to vehicle properties to the authorised `AID_VEHICLE_NETWORK` process.

1. Instantiate the VHAL service that implements the interface and register it as a binder service in the VHAL implementation.

        #include <VHalService.h>

        int main(int /* argc */, char* /* argv */[]) {
            ...
            ...
            configureRpcThreadpool(4, true);
            auto vendor_vhal_service = std::make_unique<VHalService>();
            status_t status = vendor_vhal_service->registerAsService();
            if (status != OK) {
                return 1;
            }
            joinRpcThreadpool();
            return 1;
        }

After implementing the Anbox HIDL interfaces and integrating them into your VHAL implementation, [build](https://source.android.com/docs/setup/build/building) the VHAL module. Then follow the instructions for [customising the Anbox VHAL](https://documentation.ubuntu.com/anbox-cloud/en/latest/howto/android/custom-vhal/) and load it as an addon during the Android runtime. Once registered, the service can be accessed by the Anbox VHAL adapter.

## Related topics

- {ref}`howto-create-addons`
- {ref}`howto-addons`
- {ref}`howto-extend-application`
