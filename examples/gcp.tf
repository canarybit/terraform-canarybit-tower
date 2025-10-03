
terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 6.8"
    }
  }
}

provider "google" {}

// =====================
//  Tower Arguments
// =====================

variable "cb_login" {
  description = "Enter your CanaryBit Authentication token."
  type = string
}

// =====================
//  Confidential VM (CVM)
// =====================

// AMD SNP
module "cvm-amd-snp" {
  source  = "canarybit/tower/canarybit//modules/gcp"
  cb_auth = var.cb_login
  
  // CVM Info
  cvm_name = "demo-cvm"
  cvm_ssh_enabled = true
  cvm_ssh_pubkey = "~/.ssh/id_rsa.pub"
  cvm_size = "n2d-standard-2"

  // Remote Attestation
  remote_attestation = {
    cc_environments = "snp"
  }
}

// Intel TDX
module "cvm-intel-tdx" {
  source  = "canarybit/tower/canarybit//modules/gcp"
  cb_auth = var.cb_login
  
  // CVM Info
  cvm_name = "demo-cvm"
  cvm_ssh_enabled = true
  cvm_ssh_pubkey = "~/.ssh/id_rsa.pub"
  cvm_size = "c3-standard-4"

  // Remote Attestation
  remote_attestation = {
    cc_environments = "tdx"
  }
}

// =====================
//  Print CVM info
// =====================
output "cvm-amd-snp" {
  description = "Details of the running AMD SNP CVM instance(s)"
  value = module.cvm-amd-snp.cvm-info
}

output "cvm-intel-tdx" {
  description = "Details of the running Intel TDX CVM instance(s)"
  value = module.cvm-intel-tdx.cvm-info
}