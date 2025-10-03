terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.5.0"
    }
  }
}

provider "aws" {}

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

// AMD SEV-SNP
module "cvm-amd-snp" {
  source  = "canarybit/tower/canarybit//modules/aws"
  cb_auth = var.cb_login
  
  // CVM Info
  cvm_name = "demo-cvm-amd-snp"
  cvm_ssh_enabled = true
  cvm_ssh_pubkey = "~/.ssh/id_rsa.pub"
  cvm_size = "c6a.xlarge"

  // Remote Attestation
  remote_attestation = {
    cc_environments = "snp"
  }
}

// =====================
//  Print CVM info
// =====================
output "cvm-amd-snp" {
  description = "Details of the running AMD SNP CVM instance(s)"
  value = module.cvm-amd-snp.cvm-info
}