output "cvm-info" {
  description = "Details of the running CVM instance(s)"
  value = <<EOF
  
  Name:           ${var.cvm_name}
  Size/Family:    ${var.cvm_size} (Confidential) 
  OS:             ${var.cvm_os}
  Disk:           ${var.cvm_disk_size_gb} GB 
  PublicIp:       ${azurerm_linux_virtual_machine.cvm.public_ip_address}
  SshEnabled:     ${var.cvm_ssh_enabled}
  Username:       ${var.cvm_username}
  
  Secure Boot:    ${azurerm_linux_virtual_machine.cvm.secure_boot_enabled}
  vTPM:           ${azurerm_linux_virtual_machine.cvm.vtpm_enabled}
  
  ResourceGroup:  ${azurerm_linux_virtual_machine.cvm.resource_group_name}
  Location:       ${azurerm_linux_virtual_machine.cvm.location}

  EnclaveID / Signing Key Fingerprint:
    ${data.local_file.signing-key-fingerprint.content}

  EOF
}

output "cloud-init" {
  value = <<EOF
  
  ${azurerm_linux_virtual_machine.cvm.user_data}

  EOF
}