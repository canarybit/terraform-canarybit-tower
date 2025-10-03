output "cvm-info" {
  description = "Details of the running CVM instance(s)"
  value = <<EOF

  Name:           ${var.cvm_name}
  Size/Family:    ${var.cvm_size} (Confidential) 
  OS:             ${var.cvm_os}
  Disk:           ${var.cvm_disk_size_gb} GB
  PublicIp:       ${aws_instance.cvm.public_ip}
  SshEnabled:     ${var.cvm_ssh_enabled}
  Username:       ${var.cvm_username}

  EnclaveID / Signing Key Fingerprint:
    ${data.local_file.signing-key-fingerprint.content}

  EOF
}

output "cloud-init" {
  description = "The cloud-init configuration of the running CVM instance(s)"
  value = <<EOF
  
  ${aws_instance.cvm.user_data}

  EOF
}