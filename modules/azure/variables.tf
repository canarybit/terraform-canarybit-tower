///////////////////////
// REQUIRED
///////////////////////

variable "cb_auth" {
  description = "CanaryBit Authentication tokens"
  type = string
}

variable "cvm_name" {
  description = "Confidential VM name"
  type = string
}

variable "cvm_ssh_pubkey" { 
  description = "Path to the public key used for SSH connection"
  type = string
}

variable "az_resource_group_name" {
  description = "Azure Resource Group Name"
  type = string
}

variable "az_region" {
  description = "Azure Region with AMD SNP or Intel TDX hardware"
  type = string
}

///////////////////////
// DEFAULT
///////////////////////

variable "remote_attestation" {
  description = "Enable CanaryBit Inspector Remote Attestation"
  type = object({
    cc_environments = string
    cbinspector_url = optional(string, "https://inspector.confidentialcloud.io")
    cbclient_version = optional(string, "0.2.2")
    cbcli_version = optional(string, "0.2.0")
    signing_key = optional(string)
  })
  default = null
}

variable "cvm_size" {
  description = "Supported sizes are `Standard_DC*` or `Standard_EC*` series"
  type = string

  validation {
    condition = length(regexall("^Standard_[D,E]C+", var.cvm_size)) > 0
    error_message = "Valid values are Standard_DC* or Standard_EC* series"
  }
}

variable "cvm_os" {
  description = "URN of the OS image"
  type = string
  default = "canonical:ubuntu-24_04-lts:cvm:latest"
}

variable "cvm_username" {
  description = "CVM Username for SSH login"
  type = string
  default = "tower"
}

variable "cvm_disk_size_gb" {
  description = "CVM Disk size"
  type = string
  default = "30"
}

variable "cvm_ports_open" {
  description = "List of CVM open network ports"
  type = list(string)
  default = []
}

variable "cvm_ssh_enabled" {
  description = "Enable/Disable SSH login"
  type = bool
  default = null
}