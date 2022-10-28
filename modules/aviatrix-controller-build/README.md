## Aviatrix - Google Cloud Terraform Modules - Build Aviatrix Controller

### Description
This Terraform module creates an Aviatrix Controller and related components in a Google Cloud environment. The
components created include:

* One Aviatrix Controller Google Compute Instance (named aviatrix-controller)

### Usage:

To create an Aviatrix Controller:

```hcl
module "aviatrix-controller-build" {
  source              = "AviatrixSystems/gcp-controller/aviatrix//modules/aviatrix-controller-build"
  network             = "<<< insert network name or self_link here >>>"
  subnetwork          = "<<< insert subnetwork name or self_link here >>>"
  public_ip           = "<<< insert public IP address here, ie. 1.1.1.1 >>>"
  incoming_ssl_cidrs  = ["<<< subnet CIDR >>>", "<<< CIDRs allowed for HTTPS access >>>"]
}
```

### Variables

- **network**

  The name or self_link of an existing Google Compute Network.

- **subnetwork**

  The name or self_link of an existing Google Compute Subnetwork of the given **network**.

- **public_ip**

  Existing public IP Address to assign to the Aviatrix Controller.

- **controller_name**

  Name of controller that will be launched. If not set, a default name will be used.

- **service_account_email**

  Email of a service account to attach to the Aviatrix Controller instance. If not set, no service account will be attached.

- **service_account_scopes**

  List of scopes to assign to the service account. If not set, defaults to ["cloud-platform"].

- **controller_machine_type**

  The machine type to create the Aviatrix Controller. If not set, defaults to "e2-standard-2".

- **firewall_name**

  Name of the firewall to be created. Default value: "aviatrix-controller-firewall".

- **incoming_ssl_cidrs**

  List of CIDRs allowed for HTTPS access to the Aviatrix Controller.

- **network_tags**

  A set of compute instance network tags. Default: ["controller"].

### Outputs

- **private_ip**

  The private IP address of the Google Compute instance created for the controller.

- **public_ip**

  The public IP address of the Google Compute instance created for the controller.
