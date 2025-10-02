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
  description = <<EOT
    Supported sizes are:
      - AMD SNP: M6a, C6a, R6a
      - Intel TDX: M7i, M7i-flex
  EOT
  type = string

  validation {
    condition = length(regex("(^((m6a|c6a|r6a|m7i|m7i^-flex)))(\\.)([a-z0-9]+)", var.cvm_size)) > 0
    error_message = "Supported sizes are M6a, C6a, R6a for AMD SNP and nd M7i, M7i-flex for Intel TDX"
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
  description = "AMI of the OS image"
  type = string
  default = "ami-09040d770ffe2224f" // Canonical, Ubuntu, 24.04 LTS, amd64 noble image build on 2024-04-23
}

variable "cvm_username" {
  description = ""
  type = string
  default = "tower"
}

variable "cvm_disk_size_gb" {
  description = ""
  type = string
  default = "30"
}

variable "cvm_ports_open" {
  description = ""
  type = list(string)
  default = []
}

variable "cvm_ssh_enabled" {
  description = ""
  type = bool
  default = null
}
