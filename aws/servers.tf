///////////////////////
// AMD SNP
///////////////////////

resource "aws_instance" "cvm" {
  tags = {
    Name = var.cvm_name
  }

  ami = var.cvm_os
  instance_type = var.cvm_size

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

  vpc_security_group_ids = [aws_security_group.default.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.cvm_disk_size_gb
    delete_on_termination = true
  }

  cpu_options {
    amd_sev_snp = strcontains(var.remote_attestation.cc_environments, "snp") ? "enabled" : null // Enable AMD SEV-SNP
  }

}