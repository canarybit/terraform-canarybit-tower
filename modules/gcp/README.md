# GCP Confidential VM

Terraform module to orchestrate GCP Confidential VM (CVM) instances.

## Authentication

Official documentation
https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication

Once `gcloud` is installed on your machine, run:
```
$ gcloud auth application-default login
```
and export the following environment variables:
```
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json"
export GOOGLE_PROJECT=***
export GOOGLE_ZONE=***
```

## Module wrappers

Users of this Terraform module can create multiple similar resources by using for_each meta-argument within module block.

Users of Terragrunt can achieve similar results by using modules provided in the wrappers directory, if they prefer to reduce amount of configuration files.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.8.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.rules](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.cvm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_network.cvm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [local_sensitive_file.signing-key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [null_resource.signing-key-fingerprint](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.rsa-4096](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [local_file.signing-key-fingerprint](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cb_auth"></a> [cb\_auth](#input\_cb\_auth) | n/a | `string` | n/a | yes |
| <a name="input_cvm_disk_size_gb"></a> [cvm\_disk\_size\_gb](#input\_cvm\_disk\_size\_gb) | n/a | `string` | `"0"` | no |
| <a name="input_cvm_name"></a> [cvm\_name](#input\_cvm\_name) | n/a | `string` | n/a | yes |
| <a name="input_cvm_os"></a> [cvm\_os](#input\_cvm\_os) | n/a | `string` | `"ubuntu-2404-lts-amd64"` | no |
| <a name="input_cvm_ports_open"></a> [cvm\_ports\_open](#input\_cvm\_ports\_open) | n/a | `list(string)` | `[]` | no |
| <a name="input_cvm_size"></a> [cvm\_size](#input\_cvm\_size) | Supported VM sizes: N2D for AMD SNP or C3 for Intel | `string` | n/a | yes |
| <a name="input_cvm_ssh_enabled"></a> [cvm\_ssh\_enabled](#input\_cvm\_ssh\_enabled) | n/a | `any` | `null` | no |
| <a name="input_cvm_ssh_pubkey"></a> [cvm\_ssh\_pubkey](#input\_cvm\_ssh\_pubkey) | Path to the public key used for SSH connection | `string` | n/a | yes |
| <a name="input_cvm_username"></a> [cvm\_username](#input\_cvm\_username) | n/a | `string` | `"tower"` | no |
| <a name="input_remote_attestation"></a> [remote\_attestation](#input\_remote\_attestation) | Enable CanaryBit Inspector Remote Attestation | <pre>object({<br/>    cc_environments = string<br/>    cbinspector_url = optional(string, "https://inspector.confidentialcloud.io")<br/>    cbclient_version = optional(string, "0.2.2")<br/>    cbcli_version = optional(string, "0.2.0")<br/>    signing_key = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud-init"></a> [cloud-init](#output\_cloud-init) | n/a |
| <a name="output_cvm-info"></a> [cvm-info](#output\_cvm-info) | Details of the running CVM instance(s) |
<!-- END_TF_DOCS -->