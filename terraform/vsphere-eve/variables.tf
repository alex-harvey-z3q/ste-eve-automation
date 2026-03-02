variable "booking_id" { type = string }
variable "vm_name_prefix" { type = string  default = "eve" }

variable "vsphere_server" { type = string }
variable "vsphere_user"   { type = string }
variable "vsphere_password" { type = string, sensitive = true }

variable "datacenter" { type = string }
variable "cluster"    { type = string }
variable "datastore"  { type = string }
variable "network"    { type = string }

variable "template_name" { type = string }
variable "folder"        { type = string default = "STE/EVE" }

variable "cpu" { type = number default = 8 }
variable "ram_mb" { type = number default = 32768 }