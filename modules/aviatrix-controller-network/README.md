## Aviatrix - Google Cloud Terraform Modules - Build Aviatrix Controller Network

### Description
This Terraform module creates the network for an Aviatrix Controller in a Google Cloud environment. The
components created include:

* One Google Compute Network
* One Google Compute Subnetwork

### Usage:

To create the network and subnetwork:

```hcl
module "aviatrix-controller-network" {
  source              = "mlin-aviatrix/controller-gcp//modules/aviatrix-controller-network"
  subnet_cidr         = "10.128.0.0/16"
}
```


### Variables

- **network_name**

  The name of the network to be created. If not set, defaults to "aviatrix-controller-network".

- **subnet_name**

  The name of the subnetwork to be created. If not set, defaults to "aviatrix-controller-subnetwork".

- **subnet_cidr**

  The CIDR for the Google Subnetwork that will be created. If not set, defaults to "10.128.0.0/9".

### Outputs

- **network**

  self_link of the network created for the Aviatrix Controller.

- **subnetwork**

  self_link of the subnetwork created for the Aviatrix Controller.
