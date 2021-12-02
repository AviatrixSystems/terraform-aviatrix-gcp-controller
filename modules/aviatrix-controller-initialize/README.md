## Aviatrix - Google Cloud Terraform Modules - Initialize Controller

### Description
This Terraform module the Aviatrix Controller created in a Google Cloud environment.

### Usage:

To initialize an Aviatrix Controller:


```hcl
module "aviatrix_controller_initialize" {
  source                              = "mlin-aviatrix/controller-gcp/aviatrix//modules/aviatrix-controller-initialize"
  avx_controller_public_ip            = "<<< Public IP Address of the Aviatrix Controller >>>"
  avx_controller_private_ip           = "<<< Private IP Address of the Aviatrix Controller >>>"
  avx_controller_admin_email          = "<< your admin email address for the Aviatrix Controller >>"
  avx_controller_admin_password       = "<< your admin password for the Aviatrix Controller >>"
  gcloud_project_credentials_filepath = "<< absolute path to Google Cloud project credentials >>"
  access_account_name                 = "<< your account name mapping to your GCloud account >>"
  aviatrix_customer_id                = "<< your customer license id >>"
  controller_version                  = "<< desired controller version. defaults to 'latest' >>"
}
```

### Variables

- **avx_controller_public_ip**

  The public IP Address of the Aviatrix Controller.

- **avx_controller_private_ip**

  The private IP Address of the Aviatrix Controller.

- **avx_controller_admin_email**

  The admin email address for the Aviatrix Controller

- **avx_controller_admin_password**

  The admin password for the Aviatrix Controller

- **gcloud_project_credentials_filepath**

  The absolute path to the Google Cloud project credentails

- **access_account_name**

  The name of the access account to create on the Aviatrix Controller.

- **aviatrix_customer_id**

  The customer license ID for the Aviatrix Controller

- **controller_version**

  The desired Aviatrix Controller version. If not set, defaults to "latest".
