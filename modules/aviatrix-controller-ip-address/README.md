## Aviatrix - Google Cloud Terraform Modules - Build Controller IP Address

### Description
This Terraform module creates a public IP Address in a Google Cloud environment. The
components created include:

* One Google Compute Address


### Usage:

To create a public IP Address:

```hcl
module "aviatrix-controller-ip-address" {
  source = "mlin-aviatrix/controller-gcp/aviatrix//modules/aviatrix-controller-ip-address"
}
```

### Variables

- **ip_address_name**

  The name of the Google Compute Address to create.  If not set, defaults to "aviatrix-controller-address".

### Outputs

- **public_ip**

  The public IP address of the Google Compute instance created for the controller.
