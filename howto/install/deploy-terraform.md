(howto-deploy-anbox-terraform)=
# How to deploy Anbox Cloud with Terraform

To deploy Anbox Cloud using Terraform, you need to use the Juju provider for Terraform.

```{note}
The terraform plan is a work in progress and makes use of [terraform-provider-juju](https://github.com/juju/terraform-provider-juju)
which is in active development too. Please expect breaking changes (if required) in the future for the terraform plan.
```

## Prerequisites

Before you start the installation, ensure that you have the required credentials and prerequisites:

* An Ubuntu 22.04 LTS to run the commands (or another operating system that supports snaps - see the [Snapcraft documentation](https://snapcraft.io/docs/installing-snapd)).
* Your Ubuntu Pro token for an Ubuntu Pro subscription. If you don't have one yet, [speak to your Canonical representative](https://anbox-cloud.io/contact-us). If you already have a valid Ubuntu Pro token, log in to [Ubuntu Pro website](https://ubuntu.com/pro) to retrieve it.
  ```{caution}
  The *Ubuntu Pro (Infra-only)* token does **NOT** work and will result in a failed deployment. You need an Ubuntu Pro subscription.
  ```
* A Juju Controller bootstrapped and connected to your Juju Client (CLI). See {ref}`sec-setup-juju-controller` for information on how to setup a Juju Controller.

## Install Terraform

[Terraform](https://developer.hashicorp.com/terraform) is an infrastructure as code (IaC) tool that lets you build, change, and version infrastructure safely and efficiently.

To install Terraform, enter the following command:

    sudo snap install --classic --channel=latest/stable terraform

## Initialize Terraform

To initialize Terraform to deploy Anbox Cloud, you need to use a terraform plan. A reference terraform plan is available at [Anbox Cloud Terraform](https://github.com/canonical/anbox-cloud-terraform).
Clone the given terraform plan and intialize terraform using:

    git clone https://github.com/canonical/anbox-cloud-terraform
    cd anbox-cloud-terraform
    terraform init

This will download the required providers for the terraform plan with their correct versions including the Juju provider for terraform.

## Deploy Anbox Cloud

```{note}
The current reference terraform plan maps a basic Anbox Cloud deployment with a limited amount of configuration options. However, in most cases you will want to customize the deployment based on your current infrastructure requirements.

Therefore, the recommended way to go forward is to modify the cloned plan according to your needs.
```

To provide necessary configuration values to the terraform plan, you will need to create a `tfvars` file. You can create a file called `deploy.tfvars`, which should look like the following:

    ubuntu_pro_token = "<your_ubuntu_pro_token>"
    constraints      = ["arch=arm64"]
    anbox_channel    = "1.26/stable" // Channel to use for deploying Anbox Cloud
    subclusters = [
      {
        name           = "a" // Suffix for the Juju model designated to an Anbox Subcluster
        lxd_node_count = 1  // Number of LXD nodes to deploy in the Anbox Subcluster
      }
    ]

To see what will be deployed by the terraform plan, run the following command:

    terraform plan -out=tfplan -var-file=deploy.tfvars

If everything looks fine, you can go ahead and let terraform deploy the resources. This can be done using the following command:

    terraform apply tfplan -parallelism=1

```{note}
You should use the terraform option `-parallelism=1` to increase the reliability for the plan to successfully apply.
```

This should create two Juju models, namely `anbox-controller` and `anbox-subcluster-a`. Check the output of the `juju models` command to see the resources created by the plan.

```sh
Model                Cloud/Region  Type  Status     Machines  Units  Access  Last connection
anbox-controller     juju/default  lxd   available         4      4  admin   1 minute ago
anbox-subcluster-a*  juju/default  lxd   available         6      6  admin   1 minute ago
```

## Monitor the deployment

After the plan is finished deploying, Juju will continue to install software and connect the different parts of the cluster together. This can take several minutes. You can monitor what's going on by running the following command:

    juju status -m anbox-controller --color
    juju status -m anbox-subcluster-a --color

## Scale the number of Anbox Subclusters

One of the advantages of using Terraform is the ability to manage infrastructure statefully. Terraform will remember and synchronize the current state of the infrastructure with what the plan expects it to be.
Terraform will generate a diff of the current state and the expected state in the defined plan when we run `terraform plan`. We can use this to scale our Anbox Cloud deployments.

To add another subcluster, you can modify the `deploy.tfvars` file created earlier as following:

    ubuntu_pro_token = "<your_ubuntu_pro_token>"
    constraints      = ["arch=arm64"]
    anbox_channel    = "1.26/stable" // Channel to use for deploying Anbox Cloud
    subclusters = [
      {
        name           = "a" // Suffix for the Juju model designated to an Anbox Subcluster
        lxd_node_count = 1  // Number of LXD nodes to deploy in the Anbox Subcluster
      },
      { // Add a new subcluster
        name           = "b"
        lxd_node_count = 1
      }
    ]

Running `terraform plan -out=tfplan` after making this change will notify you that new resources need to be created. Carefully inspect the plan to verify the resource changes.
Applying this plan in the same way as mentioned above i.e `terraform apply tfplan` will deploy the new Anbox Subcluster.

To remove a subcluster or scale down your deployment, you can modify the `deploy.tfvars` file created earlier as following:

    ubuntu_pro_token = "<your_ubuntu_pro_token>"
    constraints      = ["arch=arm64"]
    anbox_channel    = "1.26/stable"
    subclusters = [ // Scale down to a single subcluster
      {
        name           = "a"
        lxd_node_count = 1
      }
    ]

Running `terraform plan -out=tfplan` after making this change will notify you that resources need to be removed. Carefully inspect the plan to verify the resource changes.
Applying this plan in the same way as mentioned above i.e `terraform apply tfplan` will remove the required Anbox Subcluster.

## Scale the number of LXD nodes per Anbox Subcluster

Similar to the scaling operation for subclusters, we can also scale up or scale down the number of LXD nodes per subcluster.
To add or remove LXD nodes, simply modify the `lxd_node_count` variable in the `deploy.tfvars` file. This will look like the following:

    ubuntu_pro_token = "<your_ubuntu_pro_token>"
    constraints      = ["arch=arm64"]
    anbox_channel    = "1.26/stable"
    subclusters = [
      {
        name           = "a"
        lxd_node_count = 5  // Number of LXD nodes to deploy in the Anbox Subcluster
      }
    ]

Running `terraform plan -out=tfplan` after making this change will notify you that new resources need to be created. Carefully inspect the plan to verify the resource changes.
Applying this plan in the same way as mentioned above i.e `terraform apply tfplan` will deploy the new Anbox Subcluster.

## Enable HA Configuration

The terraform plan comes with a recommended high availability (HA) configuration for Anbox Cloud deployments. This can be enabled by modifying the `deploy.tfvars` file as following:

    ubuntu_pro_token = "<your_ubuntu_pro_token>"
    constraints      = ["arch=arm64"]
    anbox_channel    = "1.26/stable"
    subclusters = [
      {
        name           = "a"
        lxd_node_count = 1
      }
    ]
    enable_ha = true // Deploy HA configuration for Anbox Cloud

Running `terraform plan -out=tfplan` after making this change will notify you that new resources need to be created. Carefully inspect the plan to verify the resource changes.
Applying this plan in the same way as mentioned above i.e `terraform apply tfplan` will deploy the new Anbox Subcluster.

## Deploy AAR (Anbox Application Registry)

You can deploy the Anbox Application Registry alongside Anbox Cloud by modifying the `deploy.tfvars` file created earlier, in the following manner:

    ubuntu_pro_token = "<your_ubuntu_pro_token>"
    constraints      = ["arch=arm64"]
    anbox_channel    = "1.26/stable" // Channel to use for deploying Anbox Cloud
    subclusters = [
      {
        name           = "a"
        lxd_node_count = 5
        registry_config = { // registry configuration for the subcluster
            mode = "client"
        }
      }
    ]
    deploy_registry = true

This will deploy a new Juju model dedicated to the Anbox Application Registry. Check the output of the `juju models` command to verify that a new model was created.

```sh
Model                Cloud/Region  Type  Status     Machines  Units  Access  Last connection
anbox-controller     juju/default  lxd   available         4      4  admin   54 seconds ago
anbox-registry       juju/default  lxd   available         1      1  admin   42 seconds ago
anbox-subcluster-a*  juju/default  lxd   available         6      7  admin   36 seconds ago
```

## Add observability using COS (Canonical Observability Stack)

You can enable observability for Anbox Cloud deployments by modifying the `deploy.tfvars` file created earlier, in the following manner:

    ubuntu_pro_token = "<your_ubuntu_pro_token>"
    constraints      = ["arch=arm64"]
    anbox_channel    = "1.26/stable" // Channel to use for deploying Anbox Cloud
    subclusters = [
      {
        name           = "a"
        lxd_node_count = 1
      }
    ]
    enable_cos = true

Applying the plan using this configuration will deploy the required resources/charms to enable integration of Anbox Cloud components with COS (Canonical Observability Stack).

```{note}
The current plan does NOT create Juju relations for integrating with a COS model deployed externally.
This needs to be done manually as described [here](https://charmhub.io/topics/canonical-observability-stack/tutorials/instrumenting-machine-charms#step-4-relate-grafana-agent-to-cos-lite-prometheus-loki-and-grafana).
```

