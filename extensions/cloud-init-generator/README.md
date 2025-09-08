# Cloud-init Generator

Generate a cloud-init.yml file extending the standard Confidential VM configuration with CanaryBit Remote Attestation service (Inspector).

## Requirements

- `jq` installed

## Instructions

### 1. Downlaod `cb` CLI 

#### Linux
  
```
$ curl -fsSL https://canarybit-public-binaries.s3.eu-west-1.amazonaws.com/cb-cli/0.1.0/cb-x86_64-unknown-linux-gnu -o cb; chmod +x cb
```
  
#### Windows
  
```
curl -fsSL https://canarybit-public-binaries.s3.eu-west-1.amazonaws.com/cb-cli/0.1.0/cb-x86_64-pc-windows-msvc.exe -o cb; chmod +x cb
```
  
#### MacOS

**M-series**
  
```
curl -fsSL https://canarybit-public-binaries.s3.eu-west-1.amazonaws.com/cb-cli/0.1.0/cb-aarch64-apple-darwin -o cb; chmod +x cb
```

**Intel** 
  
```
curl -fsSL https://canarybit-public-binaries.s3.eu-west-1.amazonaws.com/cb-cli/0.1.0/cb-x86_64-apple-darwin -o cb; chmod +x cb
```

### 2. Login and get your CanaryBit credentials

Source your credentials:
```
export CB_USERNAME="***"
export CB_PASSWORD="***"
```

and retrieve your CanaryBit tokens:

```
export $CB_TOKENS=$(./cb login | jq -c)
```

### 4. Generate the cloud-init file

Example: 
```
$ ./cloud-init-gen.sh --cb-tokens $CB_TOKENS --environment snp --cvm-username demo --cvm-ssh-pubkey ~/.ssh/id_rsa.pub --cbclient-version 0.2.1 --inspector-url https://stag.inspector.confidentialcloud.cc
```

Need Help?

```
./cloud-init-gen.sh --help
```
