# Google Cloud Aviatrix - Terraform Module

## Descriptions
This Terraform module allows you to launch the Aviatrix Controller and create the Aviatrix access account connecting to the Controller in Google Cloud Platform.

## Prerequisites
1. [Terraform 0.13](https://www.terraform.io/downloads.html) - execute terraform files
2. [Google Cloud command-line interface (GCloud CLI)](https://cloud.google.com/sdk/docs/install) - GCloud authentication
3. [Python3](https://www.python.org/downloads/) - execute `aviatrix_controller_init.py` python scripts

## Available Modules
 Module  | Description |
| ------- | ----------- |
|[aviatrix_controller_build](./aviatrix_controller_build) |Builds the Aviatrix Controller VM on Google Cloud |
|[aviatrix_controller_initialize](./aviatrix_controller_initialize) | Initializes the Aviatrix Controller (setting admin email, setting admin password, upgrading controller version, and setting access account) |


## Procedures for Building and Initializing a Controller in Google Cloud
### 1. Create the Python virtual environment and install required dependencies in the terminal
``` shell
 python3 -m venv venv
```
This command will create the virtual environment. In order to use the virtual environment, it needs to be activated by the following command
``` shell
 source venv/bin/activate
```
In order to run the `aviatrix_controller_init.py` python script, dependencies listed in `requirements.txt` need to be installed by the following command
``` shell
 pip install -r requirements.txt
```

### 2. Authenticating to Google Cloud using the GCloud CLI in the terminal
``` shell
gcloud auth application-default login
```
This command will open the default browser and load Google Cloud sign in page

### 3. Build the Controller VM on Google Cloud

**build_controller.tf**
```
provider "google" {
  version = "<< terraform version >>"
  project = "<< project id >>"
  region  = "<< GCloud region to launch resources >>"
  zone    = "<< GCloud zone to launch resources >>"
}

module "aviatrix_controller_build" {
  source          = "github.com/AviatrixSystems/terraform-module-gcp.git//aviatrix-controller-build"
  
  // please only use lower case letters, numbers and hyphens in the controller_name
  controller_name = "<< your Aviatrix Controller name >>"
}

output "avx_controller_public_ip" {
  value = module.aviatrix_controller_build.aviatrix_controller_public_ip_address
}

output "avx_controller_private_ip" {
  value = module.aviatrix_controller_build.aviatrix_controller_private_ip_address
}
```
*Execute*
```shell
cd aviatrix_controller_build
terraform init
terraform apply
cd ..
```
### 4. Initialize the Controller

**controller_init.tf**
```
provider "google" {
  version = "<< terraform version >>"
  project = "<< project id >>"
  region  = "<< GCloud region to launch resources >>"
  zone    = "<< GCloud zone to launch resources >>"
}

module "aviatrix_controller_initialize" {
  source                              = "github.com/AviatrixSystems/terraform-module-gcp.git//aviatrix-controller-initialize"
  avx_controller_public_ip            = "<< public ip address of the Aviatrix Controller >>"
  avx_controller_private_ip           = "<< private ip address of the Aviatrix Controller >>"
  avx_controller_admin_email          = "<< your admin email address for the Aviatrix Controller >>"
  avx_controller_admin_password       = "<< your admin password for the Aviatrix Controller >>"
  gcloud_project_credentials_filepath = "<< absolute path to Google Cloud project credentials >>"
  access_account_name                 = "<< your account name mapping to your GCloud account >>"
  aviatrix_customer_id                = "<< your customer license id >>"
  terraform_module_path               = "<< absolute path of this terraform module >>"
}
```
*Execute*
```shell
cd aviatrix_controller_initialize
terraform init
terraform apply
cd ..
```

### Putting it all together
The controller buildup and initialization can be done using a single terraform file.
```
provider "google" {
  version = "<< terraform version >>"
  project = "<< project id >>"
  region  = "<< GCloud region to launch resources >>"
  zone    = "<< GCloud zone to launch resources >>"
}

module "aviatrix_controller_build" {
  source          = "github.com/AviatrixSystems/terraform-module-gcp.git//aviatrix-controller-build"
  // please only use lower case letters, numbers and hyphens in the controller_name
  controller_name = "<< your Aviatrix Controller name >>"
}

module "aviatrix_controller_initialize" {
  source                              = "github.com/AviatrixSystems/terraform-module-gcp.git//aviatrix-controller-initialize"
  avx_controller_public_ip            = module.aviatrix-controller-build.aviatrix_controller_public_ip
  avx_controller_private_ip           = module.aviatrix-controller-build.aviatrix_controller_private_ip
  avx_controller_admin_email          = "<< your admin email address for the Aviatrix Controller >>"
  avx_controller_admin_password       = "<< your admin password for the Aviatrix Controller >>"
  gcloud_project_credentials_filepath = "<< absolute path to Google Cloud project credentials >>"
  access_account_name                 = "<< your account name mapping to your GCloud account >>"
  aviatrix_customer_id                = "<< your customer license id >>"
  terraform_module_path               = "<< absolute path of this terraform module >>"
}

output "avx_controller_public_ip" {
  value = module.aviatrix_controller_build.aviatrix_controller_public_ip_address
}
```
*Execute*
```shell
terraform init
terraform apply
```
