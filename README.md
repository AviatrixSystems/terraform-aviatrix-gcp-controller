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

### 2. Authenticating to Google Cloud
#### 2a. Using the Gcloud CLI in the terminal
The easiest way to authenticate is to run:
``` shell
gcloud auth application-default login
```
This command will open the default browser and load Google Cloud sign in page

#### 2b. Using a Service Account 
Alternatively, a Google Cloud Service Account can be used with Terraform to authenticate. Download the JSON key file from an existing Service Account or from a newly created one. Supply the key to Terraform using the `GOOGLE_APPLICATION_CREDENTIALS` environment variable.
```shell
export GOOGLE_APPLICATION_CREDENTIALS={{path to key file}}
```
More information about using a Service Account to authenticate can be found in the Google Terraform documentation [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#adding-credentials).

### 3. Enabling Google Compute Engine API
The Google Compute Engine API must be enabled in order to create the Aviatrix Controller.

#### 3a. Using the Google Console
To enable the Google Compute Engine API using the Google Console:
1. Go to the [Google Compute Engine API page](https://console.cloud.google.com/apis/library/compute.googleapis.com?project=_)
2. From the projects list, select the project you want to use.
3. On the API page, click ENABLE.

More detailed information about enabling APIs can be found in Google's Cloud API documentation [here](https://cloud.google.com/apis/docs/getting-started#enabling_apis).

#### 3b. Using Terraform
Alternatively, the Google Compute Engine API can be enabled using Terraform. Using the `google_project_service` resource to enable an API requires [Service Usage API](https://console.cloud.google.com/apis/library/serviceusage.googleapis.com?project=_) to be enabled.

**enable_api.tf**
```hcl
provider "google" {
  project = "<< project id >>"
  region  = "<< GCloud region to launch resources >>"
  zone    = "<< GCloud zone to launch resources >>"
}

resource google_project_service "compute_service" {
  service = "compute.googleapis.com"
}

terraform {
  required_providers{
    google {
      source  = "hashicorp/google"
      version = "<< Google Terraform provider version >>"
    }
  }
}
```
*Execute*
```shell
terraform init
terraform apply
```

### 4. Build and Initialize the Aviatrix Controller

**main.tf**
```hcl
provider "google" {
  project = "<< project id >>"
  region  = "<< GCloud region to launch resources >>"
  zone    = "<< GCloud zone to launch resources >>"
}

module "aviatrix-controller-gcp" {
  source = "mlin-aviatrix/controller-gcp"
  access_account_name                 = "<< your account name mapping to your GCloud account >>"
  aviatrix_controller_admin_email     = "<< your admin email address for the Aviatrix Controller >>"
  aviatrix_controller_admin_password  = "<< your admin password for the Aviatrix Controller >>"
  aviatrix_customer_id                = "<< your customer license id >>"
  gcloud_project_credentials_filepath = "<< absolute path to Google Cloud project credentials >>"
  incoming_ssl_cidrs                  = ["<<< subnet CIDR >>>", "<<< CIDRs allowed for HTTPS access >>>"]
}

terraform {
  required_providers{
    google {
      source  = "hashicorp/google"
      version = "<< Google Terraform provider version >>"
    }
  }
}
```
*Execute*
```shell
terraform init
terraform apply
```
