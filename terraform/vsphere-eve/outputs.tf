output "vm_name" {
  value = vsphere_virtual_machine.eve.name
}

output "eve_ip" {
  value = try(vsphere_virtual_machine.eve.default_ip_address, "")
}