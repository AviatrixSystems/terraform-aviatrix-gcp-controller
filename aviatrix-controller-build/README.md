## Aviatrix - Google Cloud Terraform Modules - Build Aviatrix Controller

### Description
This Terraform module creates an Aviatrix Controller and related components in a Google Cloud environment. The
components created include:

* One Aviatrix Controller Google Compute Instance (named aviatrix-controller)


### Optional:
This Terraform module will create any of these optional components if they are not provided.

* An existing Google Compute Network with port 443 open for https
* An existing Google Compute Image with the Aviatrix Controller image
* A Google Compute Public IP Address

### Usage:

To create an Aviatrix Controller from scratch:

```hcl
module "aviatrix-controller-build" {
  source              = "github.com/AviatrixSysmtes/terraform-module-gcp.git//aviatrix-controller-build"
  subnet_cidr         = "10.128.0.0/9"
  incoming_ssl_cidrs  = ["<<< subnet CIDR >>>", "<<< CIDRs allowed for HTTPS access >>>"]
}
```


To create an Aviatrix Controller with existing components:
```hcl
module "aviatrix-controller-build" {
  source              = "github.com/AviatrixSysmtes/terraform-module-gcp.git//aviatrix-controller-build"
  network             = "<<< insert network name or self_link here >>>"
  subnetwork          = "<<< insert subnetwork name or self_link here  >>>"
  image               = "<<< insert image name or self_link here >>>"
  public_ip           = "<<< insert IP address here, ie. 1.1.1.1>>>"
  incoming_ssl_cidrs  = ["<<< subnet CIDR >>>", "<<< CIDRs allowed for HTTPS access >>>"]
}
```

### Variables

- **network**

  The name or self_link of an existing Google Compute Network. If not set, a Google Compute Network and Subnetwork with cidr "10.128.0.0/9" will be created.

- **subnetwork**

  The name or self_link of an existing Google Compute Subnetwork of the given **network**. **subnetwork** must be empty if **network** is not provided.

- **subnet_cidr**

  The CIDR for the Google Subnetwork that will be created. Must be empty if **network** is set. Default value is "10.128.0.0/9".

- **image**

  The name or self_link of an existing Google compute image with the Aviatrix Controller Image. If not set, a Google Compute Image with the Aviatrix Controller image will be created.

- **public_ip**

  Existing public IP Address to assign to the Aviatrix Controller. If not set, a Google Compute public IP address will be created.

- **controller_name**

  Name of controller that will be launched. If not set, default name will be used.

- **service_account_email**

  Email of a service account to attach to the Aviatrix Controller instance. If not set, no service account will be attached.

- **service_account_scopes**

  List of scopes to assign to the service account. If not set, defaults to ["cloud-platform"].

- **controller_machine_type**

  The machine type to create the Aviatrix Controller. If not set, defaults to "e2-standard-2".

- **incoming_ssl_cidrs**

  List of CIDRs allowed for HTTPS access to the Aviatrix Controller.

### Outputs

- **private_ip**

  The private IP address of the Google Compute instance created for the controller.

- **public_ip**

  The public IP address of the Google Compute instance created for the controller.
