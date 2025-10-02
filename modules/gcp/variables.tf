///////////////////////
// REQUIRED
///////////////////////

variable "cb_auth" {
  description = ""
  type = string
}

variable "cvm_name" {
  description = ""
  type = string
}

variable "cvm_ssh_pubkey" { 
  description = "Path to the public key used for SSH connection"
  type = string
}

variable "cvm_size" {
  description = "Supported VM sizes: N2D for AMD SNP or C3 for Intel"
  type = string
  validation {
    condition = length(regexall("^[n2d,c3]+", var.cvm_size)) > 0
    error_message = "ERROR - Invalid VM size"
  }
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

variable "cvm_os" {
  description = ""
  type = string
  default = "ubuntu-2404-lts-amd64"
}

variable "cvm_username" {
  description = ""
  type = string
  default = "tower"
}

variable "cvm_disk_size_gb" {
  description = ""
  type = string
  default = "0"
}

variable "cvm_ports_open" {
  description = ""
  type = list(string)
  default = []
}

variable "cvm_ssh_enabled" {
  description = ""
  default = null
}