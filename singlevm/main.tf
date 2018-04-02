#####################################################################
##
##      Created 4/2/18 by ucdpadmin. for cam-project
##
#####################################################################

terraform {
  required_version = "> 0.11.3"
}

provider "ibm" {
  version = "~> 0.7"
}

resource "ibm_compute_vm_instance" "nodejs" {
  cores       = 1
  memory      = 1024
  domain      = "${var.nodejs_domain}"
  hostname    = "${var.nodejs_hostname}"
  datacenter  = "${var.nodejs_datacenter}"
  ssh_key_ids = ["${ibm_compute_ssh_key.ibm_cloud_temp_public_key.id}"]
  os_reference_code = "${var.nodejs_os_reference_code}"
  provisioner "remote-exec" {
     inline = [
        "chmod +x /tmp/installation.sh; bash /tmp/installation.sh"
      ]
  }
  provisioner "file" {
    destination = "/tmp/installation.sh"
    content     = <<EOT
#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
LOGFILE="/var/log/install_nodejs.log"
echo "---start installing node.js---" | tee -a $LOGFILE 2>&1
yum install gcc-c++ make -y                                                        >> $LOGFILE 2>&1 || { echo "---Failed to install build tools---" | tee -a $LOGFILE; exit 1; }
curl -sL https://rpm.nodesource.com/setup_7.x | bash -                             >> $LOGFILE 2>&1 || { echo "---Failed to install the NodeSource Node.js 7.x repo---" | tee -a $LOGFILE; exit 1; }
yum install nodejs -y                                                              >> $LOGFILE 2>&1 || { echo "---Failed to install node.js---"| tee -a $LOGFILE; exit 1; }
echo "---finish installing node.js---" | tee -a $LOGFILE 2>&1
EOF

EOT
}
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "ibm_cloud_temp_public_key" {
  label = "ibm-cloud-temp-public-key"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}

