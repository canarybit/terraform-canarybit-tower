terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {
  features {}
}

// =====================
// Tower Arguments
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

// ========================
//  Confidential VM (CVM)
// ========================

module "confidential-vm" {
  count = var.n_of_cvm

  source = "canarybit/tower/canarybit//modules/azure"
  
  cb_username = var.cb_username
  cb_password = var.cb_password

  // Azure Info
  az_resource_group_name = "continuoustesting1932"

  // Confidential VM
  cvm_name = "demo-cvm-${count.index}"
  cvm_ssh_enabled = true
  cvm_ssh_pubkey = "~/.ssh/id_rsa.pub"
  cvm_size = "Standard_DC2as_v5"
  
  // Remote Attestation
  remote_attestation = {
    cc_environments = "snp"
  }
}

// ========================
//  Print CVM info
// ========================

output "cvm-amd-snp-info" {
  value = module.cvm-amd-snp.*.cvm-info
}
