# 🗼Tower  

[Tower](https://www.canarybit.eu/confidential-cloud-tower/) is a security orchestration tool to provision, control and 
maintain Confidential VM instances.
Tower integrates with a long list of Cloud Service Providers (CSPs), private and bare-metal infrastructure to provide 
governance of the resources defining your Trusted Execution Environment (TEE).

It implements Infrastructure-as-Code (IaC) and SecDevOps best-practices to provide integrity and state of the art security to your workloads runtime.

## 🌟 Features
- 🤹 **Confidential VM Orchestration**: Deploy confidential VMs on AMD SEV-SNP and Intel TDX platforms.
- 🔬 **Hardware & Environment Verification**: Integrate with [CanaryBit Inspector](https://www.canarybit.eu/confidential-cloud-inspector/) to support Remote Attestation of deployed confidential VMs. (* Requires a CanaryBit account)
- 🛠 **Extensible Configuration**: Configure your confidential VM using available configuration options or write your own.
- ⚖️ **No lock-in**: Support for multiple hardware platforms and virtualisation software.

## 🧩 Integrations
- **Galaxy server**: Support for the [Galaxy project](https://github.com/galaxyproject) for data-intensive computation.
- **Write your own**: Simple to create new integrations with custom `cloud-init` configurations.
  
## 🛠️ How It Works
1. **Clone** the repository to get the configurations.
2. **Configure** the cloud-init script fine-tune your target setup.
3. **Run** the Terraform scripts for your target Cloud Service Provider.  
4. **Need help?** Check the examples to help you get started.

## 🧱 Requirements
- [Terraform](https://developer.hashicorp.com/terraform) or [OpenTofu](https://opentofu.org/docs/intro/install/) installed;
- Credentials to access your target Cloud Service Provider;
- A SSH RSA keypair to access Confidential VM instances.

## 📖 Documentation
For setup instructions, API references, and usage examples, read the [technical documentation](https://docs.confidentialcloud.io/tower/).

## 🏀 Use Cases
- 🤖 **Confidential AI**: Train models in a secure environment to protect intellectual property at all times.
- ☁️ **Cloud infrastructure security**: Deploy workloads in memory-encrypted VMs to protect workloads from infrastructure operators.
- 🏰 **On-prem infrastructure security**: Implement defence-in-depth to protect workloads from malicious insiders and motivated adversaries.
- 💽 **High-performance computing (HPC)**: Protect security-sensitive HPC workloads 
[with minimum overhead](https://www.canarybit.eu/research-and-technological-leadership/).

## 💪 Contributing
Contributions are welcome! Please check the [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to get started.

## 🎟️ Licences

Tower is a Freemium service: basic features are free for Public Cloud setups while additional features, such as Remote Attestation and On-prem support, are offered via a paid subscription.

### 🔰 Standard
The [Apache-2.0 License](LICENSE) *free* version contains the Terraform/OpenTofu configurations for deploying Confidential VMs in **Public Clouds**.

Currently, Tower supports the following platforms and public cloud providers:

| Cloud Platform          | AMD SEV-SNP | Intel TDX   |
|-------------------------| ----------- |------------ |
| [AWS](/modules/aws)     | yes         | upcoming    |
| [Azure](/modules/azure) | yes         | yes         |
| [GCP](/modules/gcp)     | yes         | yes         |

### 💎 Premium
The Premium version contains the Terraform configurations for deploying Confidential VMs **on-premise** and for **bare-metal** setups.

Currently, Tower supports the following virtualisation plaftorms:

- [Libvirt/Qemu/KVM](https://libvirt.org/)
- [Proxmox](https://www.proxmox.com/)
- [VMware vSphere 9.0](https://www.vmware.com/products/cloud-infrastructure/vsphere)


## 🎟️ Contacts
Reach us out at [hi@canarybit.eu](mailto:hi@canarybit.eu) for more information.

/ The CanaryBit Team