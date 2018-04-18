provider "ibm" {
}

variable "cluster_name" {
  description = "The base name for the cluster."
}

resource "null_resource" "environment" {
  provisioner "local-exec" {
    #command = "bx login -a https://api.ng.bluemix.net --apikey $BLUEMIX_API_KEY && bx plugin install -f container-service && `bx cs cluster-config --export ${var.cluster_name}` && helm init "
    command = "bx login -a https://api.ng.bluemix.net --apikey $BLUEMIX_API_KEY"
  }

  provisioner "local-exec" {
    command = "bx plugin install -f container-service"
  }

  provisioner "local-exec" {
    command = "`bx cs cluster-config --export ${var.cluster_name}` && helm init"
  }
}