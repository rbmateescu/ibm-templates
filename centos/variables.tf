#####################################################################
##
##      Created 4/2/18 by ucdpadmin. for centos
##
#####################################################################

variable "centos_domain" {
  type = "string"
  description = "The domain for the computing instance."
}

variable "centos_hostname" {
  type = "string"
  description = "The hostname for the computing instance."
}

variable "centos_datacenter" {
  type = "string"
  description = "The datacenter in which you want to provision the instance. NOTE: If dedicated_host_name or dedicated_host_id is provided then the datacenter should be same as the dedicated host datacenter."
}

variable "centos_os_reference_code" {
  type = "string"
  description = "Generated"
}

