resource "google_compute_instance" "cvm" {
  name = var.cvm_name
  machine_type = var.cvm_size

  boot_disk {
    initialize_params {
      image = var.cvm_os
    }
  }

  network_interface {
    network = google_compute_network.cvm.id
    access_config {
      // Include this section to assign the VM an external IP address
    }
  }

  metadata = {
    // WARNING: it's user-data with "-" and not "_" as for other providers. No base64encode encoding.
    user-data = var.remote_attestation != null ? templatefile("${path.module}/../../cloud-init/attested.yml",
        {
          HOSTNAME           = var.cvm_name
          USERNAME           = var.cvm_username
          SSH_PUBKEY         = file(var.cvm_ssh_pubkey)
          // CanaryBit Remote Attestation
          CB_TOKENS          = data.http.cblogin.*.response_body[0]
          CBINSPECTOR_URL    = var.remote_attestation.cbinspector_url
          CBCLIENT_V         = var.remote_attestation.cbclient_version
          CBCLI_V            = var.remote_attestation.cbcli_version
          ENVIRONMENTS       = var.remote_attestation.cc_environments
          SIGNING_KEY        = indent(6,tls_private_key.rsa-4096.private_key_pem_pkcs8)
        }
      ) : templatefile("${path.module}/../../cloud-init/default.yml",
        {
          HOSTNAME           = var.cvm_name
          USERNAME           = var.cvm_username
          SSH_PUBKEY         = file(var.cvm_ssh_pubkey)
        }
    )
  }

  shielded_instance_config {
    enable_secure_boot = true
    enable_vtpm = true
    enable_integrity_monitoring = true
  }

  allow_stopping_for_update = false

  confidential_instance_config {
    confidential_instance_type = [for k,l in local.cvm_size_cpu_type_map : k if anytrue([for v in l : startswith(var.cvm_size,v)])][0]
  }

  scheduling {
    on_host_maintenance = "TERMINATE"
  }

}