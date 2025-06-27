(howto-access-android-instance)=
# Access an Android instance

As an Android application developer, you need access to the Android instance when developing and debugging applications. With our [anbox-connect](https://snapcraft.io/anbox-connect) snap, you can securely connect to an Android instance via the Android Debug Bridge (ADB).

Here's a video demonstration of how to access an Android instance securely using anbox-connect:

```{raw} html
<iframe width="640" height="360"
        src="https://www.youtube.com/embed/qsFF0eqj_JE"
        title="Debug an Android application with Android studio"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen>
</iframe>
```

## Preparation

{ref}`tut-installing-appliance`.

Install anbox-connect on your host machine: `snap install anbox-connect`.

[Install ADB](https://developer.android.com/studio/releases/platform-tools) on your host machine. You can [install Android Studio](https://developer.android.com/studio) which also installs the Android SDK (which includes ADB as part of the platform tools). You can choose to use another IDE of your choice and install ADB independently.

## Connect to the Android instance

In the appliance, create an instance with streaming enabled:

    amc launch --name=demo --enable-streaming

This creates an instance using the default image available and also creates a session for the instance.

Wait until the instance is running. To check, run:

    amc ls

After verifying that the instance is running and has a session ID, share the session:

```{note}
This guide demonstrates the steps using the appliance deployment. If you are using the charmed deployment, use `anbox-stream-gateway` instead of `anbox-cloud-appliance.gateway` in the commands.
```

    sudo anbox-cloud-appliance.gateway session share <session_id> --description="remote access to demo instance"

```{tip}
Providing a description helps you identify a shared session when you are sharing a session multiple times with different people. 
```

The output returns the command you need to run next from your host machine: `anbox-connect <connection_url>`

Copy this output. The `<connection_url>` is a presigned URL that establishes a single ADB connection — if multiple users attempt to use the same presigned URL, any existing ADB connection will be interrupted and only the last request succeeds.

> If you are using the dashboard, locate your running instance and click *Connect ADB > Authorise* to get the command with the presigned URL.

Now, create the connection from the terminal of your host machine (where ADB is installed). Run:

    anbox-connect <connection_url>

Accept the message to trust the connection. Once the ADB channel is established, the output returns guidance for the next step:

    Access to the remote Anbox Cloud instance over ADB is now possible. Please run:
        $ adb connect <ip_address>

Open a new tab in the terminal and run `adb connect <ip_address>` to connect to the Android instance. It is important to open another tab so that the established ADB connection is not aborted.

You are now connected to the Android instance and can interact with it using Android Studio. If you want a visual interface of your Android application while debugging, use the dashboard or your custom stream client to stream your instance.
