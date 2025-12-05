
terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.12.0"
    }
  }
}

provider "google" {}

// =====================
//  Tower Arguments
// =====================

variable "n_of_cvm" {
  description = "Number of Confidential VMs to deploy"
  type = number
  default = 1
}

variable "cb_username" {
  description = "CanaryBit username"
  type = string
  sensitive = true
}

variable "cb_password" {
  description = "CanaryBit password"
  type = string
  sensitive = true
}

// =====================
//  Confidential VM (CVM)
// =====================

module "confidential-vm" {
  count = var.n_of_cvm

  source  = "canarybit/tower/canarybit//modules/gcp"

  cb_username = var.cb_username
  cb_password = var.cb_password

  // Confidential VM
  cvm_name = "demo-cvm-${count.index}"
  cvm_ssh_enabled = true
  cvm_ssh_pubkey = "~/.ssh/id_rsa.pub"
  cvm_size = "c3-standard-4" // Intel TDX 

  // Remote Attestation
  remote_attestation = {
    cc_environments = "tdx"
  }
}

// ========================
//  Print CVM info
// ========================

output "cvm-info" {
  value = module.confidential-vm.*.cvm-info
}