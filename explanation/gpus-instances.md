(exp-gpus-instances)=
# GPUs and instances

Anbox Cloud supports managing GPUs and can provide them to individual instances for rendering and video encoding functionality.

```{important}
This topic is applicable only for container instances because Anbox Cloud currently does not support GPU provisioning for virtual machines. This feature is planned for a future release.
```

Anbox Cloud automatically adjusts its behaviour depending on the availability of a GPU and the presence of the `--enable-graphics` flag when you launch an instance:

    amc launch --enable-graphics my-application

The use of `--enable-graphics` flag when you launch an instance decides which platform (WebRTC or `null`) is used for rendering.

If the flag is used and there is a GPU available, Anbox Cloud launches an instance using the WebRTC platform that detects and uses the GPU.
If the flag is used and there is no GPU available, Anbox Cloud uses software rendering.
If the flag is not used, irrespective of GPU availability, Anbox Cloud uses the `null` platform and cannot perform any rendering. See {ref}`sec-null-platform` for the `null` platform configuration.

## With a GPU

If Anbox Cloud detects a GPU device during deployment, it configures the cluster to use the GPU. AMS configures each LXD instance to pass through a GPU device from the host. Currently, all GPUs that are available to a machine are passed to every instance that owns a GPU slot. For NVIDIA GPUs, LXD uses the [NVIDIA container runtime](https://github.com/NVIDIA/nvidia-container-runtime) to make the GPU driver of the host available to the instance.

To use instances instances with a GPU,

- Configure the number of available GPU slots on the node. This decides how many instances can run on a given node because GPUs have limited sharing capacity amongst multiple instances. See {ref}`sec-gpu-slots` for detailed information.
- Check the list of supported GPUs ({ref}`sec-supported-gpus`) to see if Anbox Cloud includes a driver for your GPU device. If a GPU driver is available inside the instance, there are no further differences in how to use it in comparison to a regular environment. If no GPU driver is available, you must provide it through an addon.
- Launch your instance with the `--enable-graphics` flag.

(sec-sw-rendering-video-encoding)=
## Without a GPU

Anbox Cloud provides a way to run entirely without GPU by using software rendering. You can enable software rendering and video encoding by launching your application with the `--enable-graphics` flag. When there is no GPU and this flag is enabled, Anbox Cloud falls back to using the `null` platform.

To use instances without a GPU and still perform rendering,

- Change the {ref}`sec-application-manifest-resources` of the application to not require a GPU. This tells Anbox Cloud that no GPU is available.
- Launch your instance with the `--enable-graphics` flag. The presence of this flag when there is no GPU tells Anbox Cloud to use software rendering.

Since software rendering and video encoding utilise the CPU, you won't be able to run as many instances on a system when compared to running instances with a GPU.

## Related topics
* {ref}`exp-addons`
* {ref}`ref-application-manifest`
* {ref}`ref-rendering-resources`
