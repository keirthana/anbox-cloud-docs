# Deprecation notices

This document contains a list of deprecation notices for Anbox Cloud and its components.

## Node controller
*Deprecated in 1.23.0* ; *Removal in 1.24.0*

Use of node controller to manage the port forwarding from an instance to expose a service is deprecated in 1.23.0. Instead, the Anbox Management Service (AMS) will use a LXD proxy device to manage the port forwarding.

(sec-appliance-deprecation)=
## Anbox Cloud Appliance
*Deprecated in 1.22.0* ; *Removal in 1.24.2*

The Anbox Cloud Appliance is being reworked and the current implementation is deprecated in 1.22.0. Existing installations of the current implementation will receive updates until Anbox Cloud 1.24.2. Starting from 1.23.0, new installations will receive the new implementation of the appliance.

  The new implementation of the appliance will no longer use the Juju charmed operators internally but package all necessary service components directly within the snap. This helps to simplify the installation process and reduce overall footprint.

## Ubuntu 20.04 (focal)
*Deprecated in 1.22.0* ; *Removal in 1.24.0*

Support for Ubuntu 20.04 (focal) is deprecated in 1.22.0 and is planned to be removed in Anbox Cloud 1.24.0.

## EmuGL
*Deprecated in 1.22.0* ; *Removal in 1.23.0*

Support for the EmuGL renderer is deprecated in 1.22.0 and planned to be removed in Anbox Cloud 1.23.0. Starting with 1.22.0, VirGL will be the default renderer for NVIDIA GPUs with driver version 545 and later.
