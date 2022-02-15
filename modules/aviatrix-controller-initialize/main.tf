locals {
  option = format("%s/aviatrix_controller_init.py",
    path.module
  )
  argument = format("--public_ip '%s' --private_ip '%s' --admin_email '%s' --admin_password '%s' --gcloud_project_credentials_filepath '%s' --access_account_name '%s' --aviatrix_customer_id '%s' --controller_version '%s'",
    var.avx_controller_public_ip, var.avx_controller_private_ip, var.avx_controller_admin_email,
    var.avx_controller_admin_password, var.gcloud_project_credentials_filepath, var.access_account_name,
    var.aviatrix_customer_id, var.controller_version
  )
}
resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "Python3 -W ignore ${local.option} ${local.argument}"
  }
}
