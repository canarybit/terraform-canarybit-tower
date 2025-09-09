# 🗼Tower  

[Tower](https://www.canarybit.eu/confidential-cloud-tower/) is a security orchestration tool to provision, control and 
maintain Confidential VM instances.
Tower integrates with a long list of Cloud Service Providers (CSPs), private and bare-metal infrastructure to provide 
governance of the resources defining your Trusted Execution Environment (TEE).
It implements Infrastructure-as-Code (IaC) and SecDevOps methodologies to provide integrity and state of the art security
to your workloads runtime.

## 🌟 Features
- 🤹 **Confidential VM Orchestration**: Deploy confidential VMs on AMD SEV-SNP and Intel TDX platforms.
- 🛠 **Extensible Configuration**: Configure your confidential VM using available configuration options or write your own.
- ⚖️ **No lock-in**: Support for multiple hardware platforms and virtualisation software.
- 🔬 **Attestation verification support**: Integrates with [Inspector](https://www.canarybit.eu/confidential-cloud-inspector/) 
to support remote attestation of deployed confidential VMs. Contact hi@canarybit.eu to learn more about CanaryBit's solution for remote attestation of confidential VMs.
- 🧩 **Integration with Galaxy**: Support for the [Galaxy project](https://github.com/galaxyproject) for data-intensive computation.

## 🛠️ How It Works
1. **Clone** the repository to get the configurations.
2. **Configure** the cloud-init script fine-tune your target setup.
3. **Run** the Terraform scripts for your target Cloud Service Provider.  
4. **Need help?** Check the examples to help you get started.


## 🧱 Requirements
- [Terraform](https://developer.hashicorp.com/terraform) or [OpenTofu](https://opentofu.org/docs/intro/install/) installed;
- Credentials to access your favourite Cloud Service Provider;
- An SSH key to access Confidential VM instances.

## 📖 Documentation
For setup instructions, API references, and usage examples, see the documentation:
🔗 [Documentation Link](https://docs.confidentialcloud.io/tower/)

## 🏀 Use Cases
- 🤖 **Confidential AI**: Train models in a secure environment to protect intellectual property at all times.
- ☁️ **Cloud infrastructure security**: Deploy workloads in memory-encrypted VMs to protect workloads from infrastructure operators.
- 🏰 **On-prem infrastructure security**: Implement defence-in-depth to protect workloads from malicious insiders and motivated adversaries.
- 💽 **High-performance computing (HPC)**: Protect security-sensitive HPC workloads 
[with minimum overhead](https://www.canarybit.eu/research-and-technological-leadership/).

## 💪 Contributing
Contributions are welcome! Please check the [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to get started.

## 📑 License
Tower is licensed under the **Apache-2.0 License**. See the [LICENSE](LICENSE) file for more details.
The Standard version contains the Terraform/OpenTofu configurations for deploying Confidential VMs in **Public Clouds**.
Currently Tower supports the following platforms and public cloud providers:

| Cloud Platform  | AMD SEV-SNP | Intel TDX |
|-----------------| ------- |------- |
| [AWS](/aws)     | yes    | upcoming    |
| [Azure](/azure) | yes    | upcoming    |
| [GCP](/gcp)     | yes    | yes    |

### 💎 Premium
The Premium version contains the Terraform configurations for deploying Confidential VMs **on-premise** and for **bare-metal** setups.
Currently Tower supports the following virtualisation plaftorms:

- [Libvirt/Qemu/KVM](https://libvirt.org/)
- [Proxmox](https://www.proxmox.com/)
- [VMware vSphere 9.0](https://www.vmware.com/products/cloud-infrastructure/vsphere)

Reach out to [hi@canarybit.eu](mailto:hi@canarybit.eu) if you want to use Tower to deploy confidential VMs in on-prem deployments (that requires the Premium version).

>🇪🇺 This work has been partially supported by the [TITAN project](https://elasticproject.eu/), 
> which received funding from the [Horizon Europe: Research infrastructures](https://rea.ec.europa.eu/funding-and-grants/horizon-europe-research-infrastructures_en)
> (INFRAEOSC) programme  under the European Union’s [Horizon Europe](https://research-and-innovation.ec.europa.eu/funding/funding-opportunities/funding-programmes-and-open-calls/horizon-europe_en) 
> research and innovation programme under [Grant Agreement No. 101129822](https://cordis.europa.eu/project/id/101129822). 
> Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union. 
> Neither the European Union nor the granting authority can be held responsible for them.
