resource "azurerm_linux_virtual_machine" "cvm" {
  name = var.cvm_name
  resource_group_name = data.azurerm_resource_group.default.name
  location = data.azurerm_resource_group.default.location
  size = var.cvm_size
    
  // Select the right cloud-init: default or with Remote Attestation support.
  user_data = var.remote_attestation == false ? base64encode(templatefile("${path.module}/../cloud-init/default.yml",
      {
        USERNAME           = var.cvm_username
        SSH_PUBKEY         = file(var.cvm_ssh_pubkey)
      }
    )) : base64encode(templatefile("${path.module}/../cloud-init/remote-attestation.yml",
      {
        USERNAME           = var.cvm_username
        SSH_PUBKEY         = file(var.cvm_ssh_pubkey)
        // CanaryBit Remote Attestation required info
        CB_TOKENS          = var.cb_auth
        CBINSPECTOR_URL    = var.remote_attestation.cbinspector_url
        CBCLIENT_V         = var.remote_attestation.cbclient_version
        CBCLI_V            = var.remote_attestation.cbcli_version
        CC_ENVIRONMENTS    = var.remote_attestation.cc_environments
        // Indent the signing key otherwise cloud-init will fail
        SIGNING_KEY        = indent(6,tls_private_key.rsa-4096.private_key_pem_pkcs8)
      }
  ))

  # The required AZ approach to add a VM user in addition to cloud-init config
  admin_username = var.cvm_username
  admin_ssh_key {
    username = var.cvm_username
    public_key = file(var.cvm_ssh_pubkey)
  }

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.default.id
  ]

  vtpm_enabled = true
  secure_boot_enabled = true

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
    security_encryption_type = "DiskWithVMGuestState"
    disk_size_gb = var.cvm_disk_size_gb
  }

  source_image_reference {
    publisher = local.cvm_os_urn[0]
    offer = local.cvm_os_urn[1]
    sku = local.cvm_os_urn[2]
    version = local.cvm_os_urn[3]
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}
