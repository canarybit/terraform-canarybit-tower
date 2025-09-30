terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 4.0.1"
    }
    google = {
      source = "hashicorp/google"
      version = "~> 6.8.0"
    }
  }
}

provider "aws" {}
provider "azurerm" {
  features { } 
}
provider "gcp" {}

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
module "confidential-vm" {
  source = "canarybit/tower/canarybit/<SUB_MODULE>" // <SUB_MODULE> = aws,azure,gcp
  cb_auth = var.cb_login
  
  az_resource_group_name = "<RESOURCE_GROUP_NAME>" // Only for Azure deployments

  // Confidential VM
  cvm_name = "demo-cvm"
  cvm_ssh_enabled = true
  cvm_ssh_pubkey = "~/.ssh/id_rsa.pub"

  // Remote Attestation
  remote_attestation = {
    cc_environments = "snp"
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