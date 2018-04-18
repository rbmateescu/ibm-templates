provider "ibm" {
}

variable "cluster_name" {
  description = "The base name for the cluster."
}

resource "null_resource" "environment" {
  provisioner "local-exec" {
    command = "bx login -a https://api.ng.bluemix.net --apikey $BLUEMIX_API_KEY && \
    bx plugin install -f container-service && \
    bx cs cluster-config --export $BX_CLUSTER_NAME && \ 
    helm init"
    environment {
      BX_CLUSTER_NAME = "${cluster_name}"
    }
  }
}