#####################################################################
##
##      Created 4/2/18 by ucdpadmin. for centos
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "ibm" {
  version = "~> 0.7"
}


resource "ibm_compute_vm_instance" "centos" {
  cores       = 1
  memory      = 1024
  domain      = "${var.centos_domain}"
  hostname    = "${var.centos_hostname}"
  datacenter  = "${var.centos_datacenter}"
  ssh_key_ids = ["${ibm_compute_ssh_key.ibm_cloud_temp_public_key.id}"]
  os_reference_code = "${var.centos_os_reference_code}"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "ibm_cloud_temp_public_key" {
  label = "ibm-cloud-temp-public-key"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}