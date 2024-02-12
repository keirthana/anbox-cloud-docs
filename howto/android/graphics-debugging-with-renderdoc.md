Debugging graphics can be challenging and Renderdoc is a great tool to provide insight into Vulkan and OpenGL command execution. The following describes how you can use Renderdoc with Anbox Cloud.

## Install Renderdoc

Renderdoc provides binary builds [here](https://renderdoc.org/builds). These come with all prerequisites to be able to capture on Android.

[note type="caution" status="Warning"]
The offical Renderdoc builds only support ARM and not x86 Android builds. If you need x86 support, you will have to build Renderdoc yourself from source. The official [repository](https://github.com/baldurk/renderdoc) for Renderdoc provides more information on how to do that.
[/note]

For capturing Android applications you also need the Android SDK as Renderdoc needs a few tools like `adb` or `aapt`. The easiest is to install [Android Studio](https://developer.android.com/studio) which will allow you to install the SDK.

## Configure Renderdoc

Capturing applications running in Android with Renderdoc is similar to the procedure described in [the official documentation](https://renderdoc.org/docs/how/how_android_capture.html). The most important part is to configure the path to the Android SDK in the Renderdoc settings. See [here](https://renderdoc.org/docs/window/settings_window.html#android-options) for more details.

## Configure Anbox

In order to run Renderdoc with Anbox Cloud you need to create an instance with its ADB port exposed:

    amc launch -s adb ...

See [How to access an instance](https://discourse.ubuntu.com/t/17772) for more details.

Afterwards you connect to Android by running

    adb connect <host IP>:9001

on the same machine you have Renderdoc installed.

The device will show up in the output of

    adb devices

Renderdoc can only inject itself into applications which have debug mode turn on. See [here](https://renderdoc.org/docs/how/how_android_capture.html#how-do-i-use-renderdoc-on-android) for more details.

## Capture a trace

Capturing a trace on Anbox Cloud is no different after the initial setup than on any other Android devices and you can follow the instructions [in the official documentation](https://renderdoc.org/docs/how/how_android_capture.html#).
