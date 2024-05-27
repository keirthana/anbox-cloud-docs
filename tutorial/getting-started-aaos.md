This tutorial guides you through basic operations that you can do with an application based on an Android Automotive OS (AAOS) image. 

In this tutorial, we will be specifically focusing on the following tasks:
- Creating an application using an AAOS image
- Stream the application you created with a specific screen resolution
- Set the temperature of the automotive using the Vehicle Hardware Abstraction Layer (VHAL) controls

## Prerequisites
We will use the appliance dashboard to perform the tasks for this tutorial. So if you haven’t installed the Anbox Cloud Appliance yet, you must do so before you can continue with this tutorial. Follow the installation instructions available at [How to install the Anbox Cloud Appliance](https://discourse.ubuntu.com/t/22681) to install and initialise the appliance.

## Create an AAOS-based application

On the web dashboard *Applications* screen, click *Add Application*.

Enter values for the mandatory fields, keeping the following points in mind:
- Select *Automotive* as the application type.
- Select an AAOS image. The image name should indicate whether it is an AOSP or an AAOS image. For example, `jammy:aaos13:amd64` is an AAOS image.

Click *Add application* and wait till the *Applications* list screen shows your application with a ready status.

## Stream the application with a specific screen resolution

On the *Sessions* screen, click *Create session*.

Select the application that you created earlier.

Any of the *Screen resolution* options listed for the application should work but to set a custom resolution, select *Custom* from the drop-down and set the following values:
```
Width = 2304
Height = 3072
```
Remember that screen resolutions for AAOS (automotive) applications will be different from those of the AOSP (mobile) applications because the target devices are different.

It is important to understand that higher screen resolutions consume more resources.

Select a desired *Frame rate*, for example, 60.

Click *Create session*.

## Set automotive temperature using the VHAL panel

Once the session is created, you can see the Android UI streaming. The controls on the right help you set specific automotive controls.

Try setting the temperature by performing the following steps:

- Select *All VHAL properties* on the right.
- In the *Search* bar, enter *HVAC_TEMPERATURE_SET*. 
- Click on the HVAC panel icon to open it.
- Modify the temperatures for *Area 1* and *Area 2*

As you modify the temperatures, you can see the changes reflecting on the HVAC panel.

## Learn more

Learn about the various [supported system properties in the VHAL](https://source.android.com/docs/automotive/vhal/system-properties).