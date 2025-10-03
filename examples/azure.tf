terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 4.0.1"
    }
  }
}

provider "azurerm" {
  features {}
}

// =====================
//  Tower Arguments
// =====================

variable "cb_login" {
  description = "CanaryBit Authentication tokens"
  type = string
}

// =====================
//  Confidential VM (CVM)
// =====================

// AMD SEV-SNP
module "cvm-amd-snp" {
  source  = "canarybit/tower/canarybit//modules/azure"
  cb_auth = var.cb_login

  // Azure Info
  az_resource_group_name = "<MY_RESOURCE_GROUP>"
  az_region = "westeurope"
  
  // CVM Info
  cvm_name = "demo-cvm-amd-snp"
  cvm_ssh_enabled = true
  cvm_ssh_pubkey = "~/.ssh/id_rsa.pub"
  cvm_size = "Standard_DC2as_v5"

  // Remote Attestation
  remote_attestation = {
    cc_environments = "snp"
  }
}

// Intel TDX
module "cvm-intel-tdx" {
  source  = "canarybit/tower/canarybit//modules/azure"
  cb_auth = var.cb_login

  // Azure Info
  az_resource_group_name = "<MY_RESOURCE_GROUP>"
  az_region = "westeurope"
  
  // CVM Info
  cvm_name = "demo-cvm-intel-tdx"
  cvm_ssh_enabled = true
  cvm_ssh_pubkey = "~/.ssh/id_rsa.pub"
  cvm_size = "Standard_DC2es_v6"

  // Remote Attestation
  remote_attestation = {
    cc_environments = "tdx"
  }
}

// =====================
//  Print CVM info
// =====================
output "cvm-info" {
  value = module.confidential-vm.cvm-info
}

output "cvm_cloud_init" {
  value = module.confidential-vm.cloud-init
  sensitive = true
}