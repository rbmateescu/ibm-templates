provider "ibm" {
}

resource "null_resource" "environment" {
  provisioner "local-exec" {
    command = "echo $BLUEMIX_API_KEY"
  }
}