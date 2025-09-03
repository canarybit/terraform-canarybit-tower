#!/bin/bash
set -euo pipefail

# Generates cloud-init.yml with all template variables substituted by provided values.
usage() {
  cat <<EOF
Usage: $0 [options]

Required:
  --cb-tokens <TOKENS>          CanaryBit id_ and auth_ token in a single json block
  --environment <ENV>           Target environment: [ "snp", "tdx" ]
  --cvm-username <NAME>         Username to access the VM
  --cvm-ssh-pubkey <PATH>       Path to Public Key file

Optional:
  --custom-policy <PATH>        Path to Policy file
  --inspector-url <URL>         Default: https://inspector.confidentialcloud.io
  --cbclient <VERSION>          Default: latest
  --cb-cli <VERSION>            Default: latest
  --output <PATH>               Default: ./cloud-init.yml
  -h, --help                    Show this help

Example:

  $0 \\
    --cb-tokens \$CB_TOKENS \\
    --environment snp \\
    --cvm-username john \\
    --cvm-ssh-pubkey ~/.ssh/id_rsa.pub \\
    --cbclient-version 0.2.1 \\
    --inspector-url https://stag.inspector.confidentialcloud.cc

EOF
  exit 1
}

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --cb-tokens) CB_TOKENS="$2"; shift 2 ;;
    --environment) ENV="$2"; shift 2 ;;
    --cvm-username) USERNAME="$2"; shift 2 ;;
    --cvm-ssh-pubkey) SSH_PUBKEY_FILE="$2"; shift 2 ;;
    --cbclient-version) CBCLIENT_VERSION="$2"; shift 2 ;;
    --custom-policy) CUSTOM_POLICY="$2"; shift 2 ;;
    --inspector-url) INSPECTOR_URL="$2"; shift 2 ;;
    --output) OUTFILE="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) echo "Unknown arg: $1"; usage ;;
  esac
done

# Check required arguments
: "${CB_TOKENS?:--cb-tokens is required}"
: "${ENV?:--environment is required: 'snp' or 'tdx'}"
: "${USERNAME?:--username is required}"
: "${SSH_PUBKEY_FILE?:--ssh-pubkey filepath is required}"
: "${CBCLIENT_VERSION?:--cbclient-version is required}"

# Set arguments defaults
INSPECTOR_URL="${INSPECTOR_URL:-'https://inspector.confidentialcloud.io'}"
CBCLI_VERSION="${CBCLI_VERSION:-latest}"
CUSTOM_POLICY="${CUSTOM_POLICY:-}"
OUTFILE="${OUTFILE:-./cloud-init.yml}"

# Set global variables defaults
CB_PUBLIC_REPO="https://canarybit-public-binaries.s3.eu-west-1.amazonaws.com"
CUSTOM_POLICY_CONFIG=''
CBCLIENT_ARG_POLICY=''

# Get CB CLI 'latest' version
if [[ "${CBCLI_VERSION}" == "latest" ]]; then
  CBCLI_VERSION=$(curl -fsSL $CB_PUBLIC_REPO/cb-cli/latest)
fi

# Create the Policy file (policy.rego) if file exists
if [[ -n "${CUSTOM_POLICY}" ]]; then
  CBCLIENT_ARG_POLICY="--policy policy.rego"
  CUSTOM_POLICY_CONTENT=$(cat ${CUSTOM_POLICY})
  CUSTOM_POLICY_CONFIG=$(cat <<EOF
  - path: /home/${USERNAME}/policy.rego
    owner: ${USERNAME}:${USERNAME}
    defer: true
    permissions: '0644'
    content: |
$(printf '%s\n' "${CUSTOM_POLICY_CONTENT}" | sed 's/^/      /')
EOF
)
fi

# Expand leading ~ in paths if present
SSH_PUBKEY_FILE="${SSH_PUBKEY_FILE/#\~/$HOME}"

# Read and validate SSH public key file (must exist)
if [[ ! -f "${SSH_PUBKEY_FILE}" ]]; then
  echo "Error: SSH public key file does not exist: ${SSH_PUBKEY_FILE}" >&2
  exit 2
fi

# Read single-line public key and strip CR if present
SSH_PUBKEY="$(sed -e 's/\r$//' "${SSH_PUBKEY_FILE}" | tr -d '\n')"

if [[ -z "${SSH_PUBKEY}" ]]; then
  echo "Error: SSH public key file appears empty: ${SSH_PUBKEY_FILE}" >&2
  exit 2
fi

# Check Environment values
if [[ "${ENV}" != "snp" && "${ENV}" != "tdx" ]]; then
  echo "Error: --environment must be either 'snp' or 'tdx'." >&2
  exit 2
fi

# Create output file (cloud-init YAML)
cat > "${OUTFILE}" <<EOF
#cloud-config
users:
  - default
  - name: ${USERNAME}
    groups: [canarybit]
    sudo: false
    shell: /bin/bash
    ssh_authorized_keys:
      - ${SSH_PUBKEY}

timezone: UTC
locale: "en_US.UTF-8"

package_update: true
package_upgrade: true
package_reboot_if_required: true
packages:
  - libtss2-dev
  - jq

write_files:
  - path: /etc/environment
    append: true
    content: |
      CB_TOKENS=${CB_TOKENS}
      CBCLIENT_LOG_LEVEL=info
      CBCLIENT_INSPECTOR_URL=${INSPECTOR_URL}
      CBCLIENT_ENVIRONMENTS=${ENV}

  - path: /etc/udev/rules.d/61-canarybit-udev.rules
    owner: root:root
    content: |
      # Custom udev rules for CanaryBit attestation client
      # SNP on non-Hyper-V guest
      # Preserves OWNER="root", gives the group "canarybit" ownership and read access
      KERNEL=="sev-guest",MODE="0640",GROUP="canarybit"
      # SNP on Hyper-V guest
      # Preserves OWNER="tss" and MODE="0660", gives the group "canarybit" ownership and read/write access
      KERNEL=="tpmrm0",MODE="0660",GROUP="canarybit"

${CUSTOM_POLICY_CONFIG}

  - path: /home/${USERNAME}/launch-cbclient.sh
    owner: ${USERNAME}:${USERNAME}
    defer: true
    permissions: '0755'
    content: |
      #!/bin/bash
      #############################
      # FETCH & RUN THE CBCLIENT
      #############################
      curl -fsSL ${CB_PUBLIC_REPO}/cb-cli/${CBCLI_VERSION}/cb-x86_64-unknown-linux-gnu -o cb; chmod +x cb
      ./cb download cbclient ${CBCLIENT_VERSION}/cbclient; chmod +x cbclient
      ./cbclient attestation --token \$(./cb login inspector) ${CBCLIENT_ARG_POLICY}
      
runcmd:
  - udevadm trigger
  - su -c '/home/${USERNAME}/launch-cbclient.sh' - ${USERNAME}

final_message: "==========   TOWER SETUP COMPLETED IN \$UPTIME secs    =========="
EOF

echo "Generated ${OUTFILE}"