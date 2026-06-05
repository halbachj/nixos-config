#!/usr/bin/env bash
set -euo pipefail

GITHUB_REPO="https://github.com/halbachj/nixos-config"
WORK_DIR="/tmp/nixos-install"

usage() {
  cat <<EOF
Usage: sudo nixos-installer [OPTIONS]

Semi-automated NixOS installer using your nixos-config.

Options:
  --hostname HOST   Target hostname (prompts if omitted)
  --disk DISK       Target disk device, e.g. /dev/nvme0n1 (prompts if omitted)
  --sops-key FILE   Path to age key file for sops secret decryption
  --help            Show this help

Examples:
  sudo nixos-installer
  sudo nixos-installer --hostname myserver --disk /dev/sda
EOF
}

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Error: must run as root (use sudo)"
  exit 1
fi

HOSTNAME=""
DISK=""
SOPS_KEY=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --hostname) HOSTNAME="$2"; shift 2 ;;
    --disk) DISK="$2"; shift 2 ;;
    --sops-key) SOPS_KEY="$2"; shift 2 ;;
    --help) usage; exit 0 ;;
    *) echo "Error: unknown option $1"; usage; exit 1 ;;
  esac
done

echo ""
echo "  NixOS Config Installer"
echo "========================="
echo ""

echo "[*] Checking network connectivity..."
if ! ping -c 1 -W 5 nixos.org &>/dev/null; then
  echo "[!] No network connectivity. NixOS installation requires internet."
  echo "    Connect to a network and re-run."
  exit 1
fi
echo "[ok] Network OK"

echo "[*] Getting config..."
if git clone --depth 1 "$GITHUB_REPO" "$WORK_DIR" 2>/dev/null; then
  echo "[ok] Config cloned from GitHub"
elif [[ -d "/nixos-config" ]]; then
  echo "[*] Using embedded config (offline fallback)"
  cp -a /nixos-config "$WORK_DIR"
  (cd "$WORK_DIR" && git init -q && git add -A && git commit -q -m "init")
else
  echo "[!] No config source available!"
  exit 1
fi

cd "$WORK_DIR"

echo "[*] Fixing path inputs in flake.nix..."
python3 << 'PYEOF'
import re

with open("flake.nix") as f:
    lines = f.readlines()

result = []
i = 0
while i < len(lines):
    line = lines[i]
    stripped = line.strip()

    if re.match(r'^\s+\w[\w-]*\s*=\s*\{$', stripped):
        j = i + 1
        has_abs_path = False
        brace_depth = 1
        while j < len(lines) and brace_depth > 0:
            inner = lines[j]
            brace_depth += inner.count('{') - inner.count('}')
            if re.search(r'url\s*=\s*"path:/[^."]', inner):
                has_abs_path = True
            j += 1

        if has_abs_path:
            block_text = ''.join(lines[i:j])
            name_match = re.match(r'^\s+(\w[\w-]*)\s*=\s*\{', stripped)
            input_name = name_match.group(1) if name_match else ""

            if input_name == "nix-xilinx" and 'path:/home/twostone/nixos-config/' in block_text:
                new_block = block_text.replace(
                    'path:/home/twostone/nixos-config/',
                    'path:./'
                )
                result.append(new_block)
                i = j
                continue
            elif input_name == "anvim" and '#url = "github:' in block_text:
                new_block = re.sub(
                    r'#(url\s*=\s*"github:[^"]+";)',
                    r'\1',
                    block_text
                )
                new_block = re.sub(
                    r'(url\s*=\s*"path:[^"]+";)',
                    r'#\1',
                    new_block
                )
                result.append(new_block)
                i = j
                continue
            else:
                i = j
                continue

    result.append(line)
    i += 1

with open("flake.nix", "w") as f:
    f.writelines(result)
PYEOF

if git diff --quiet flake.nix; then
  echo "[ok] No path input fixes needed"
else
  git add flake.nix
  git commit -q -m "Fix path inputs for installation"
  echo "[ok] Path inputs fixed"
fi

if [[ -z "$HOSTNAME" ]]; then
  echo ""
  echo "Existing hosts:"
  ls -1 hosts/ 2>/dev/null | grep -v iso || echo "  (none)"
  echo ""
  HOSTNAME=$(gum input --prompt "New hostname: " --placeholder "my-host")
fi

if [[ -z "$HOSTNAME" ]]; then
  echo "[!] Hostname cannot be empty"
  exit 1
fi

if [[ -d "hosts/$HOSTNAME" ]]; then
  if ! gum confirm "Host '$HOSTNAME' already exists. Overwrite?"; then
    echo "[!] Aborted"
    exit 1
  fi
  rm -rf "hosts/$HOSTNAME"
fi

if [[ -z "$DISK" ]]; then
  echo ""
  echo "Available disks:"
  lsblk -d -n -o NAME,SIZE,MODEL,TYPE 2>/dev/null | grep disk || {
    lsblk -d -n -o NAME,SIZE,TYPE 2>/dev/null | grep disk
  }
  echo ""
  DISK=$(gum input --prompt "Target disk: " --placeholder "/dev/nvme0n1")
fi

if [[ ! -b "$DISK" ]]; then
  echo "[!] $DISK is not a block device"
  exit 1
fi

echo ""
echo "--- NixOS Modules ---"
echo "Select system modules (space to toggle, enter to confirm):"
NIXOS_MODULES=(
  "desktop-base       Desktop environment (fonts, sound, power)"
  "desktop-base-extra  Extra desktop (flatpak, printing, wine)"
  "desktop-sway        Sway window manager + greetd"
  "desktop-uni         University tools (digilent, flexoptix)"
  "desktop-games       Steam gaming"
  "laptop-base         Laptop config (tlp, backlight, webcam)"
  "server-docker       Podman/Docker containers"
)

SELECTED_NIXOS=$(printf "%s\n" "${NIXOS_MODULES[@]}" | gum choose --no-limit --height 8)
SELECTED_NIXOS_NAMES=()
while IFS= read -r line; do
  [[ -n "$line" ]] && SELECTED_NIXOS_NAMES+=("$(echo "$line" | awk '{print $1}')")
done <<< "$SELECTED_NIXOS"

echo ""
echo "--- Home Manager Modules ---"
echo "Select home-manager modules:"
HOME_MODULES=(
  "desktop-base       Desktop home (ghostty, helix, browsers)"
  "desktop-base-extra  Extra desktop home (flatpak, spicetify, discord)"
  "desktop-sway        Sway home config"
  "desktop-sway-laptop Sway laptop overrides"
  "desktop-uni         University home packages"
  "games               Minecraft launcher"
  "latex-terminal      LaTeX terminal rendering"
  "users-twostone-desktop Desktop user config (email, keepassxc)"
)

SELECTED_HOME=$(printf "%s\n" "${HOME_MODULES[@]}" | gum choose --no-limit --height 9)
SELECTED_HOME_NAMES=()
while IFS= read -r line; do
  [[ -n "$line" ]] && SELECTED_HOME_NAMES+=("$(echo "$line" | awk '{print $1}')")
done <<< "$SELECTED_HOME"

echo ""
echo "--- Summary ---"
echo "  Hostname:      $HOSTNAME"
echo "  Disk:          $DISK"
echo "  NixOS modules: ${SELECTED_NIXOS_NAMES[*]:-(none)}"
echo "  Home modules:  ${SELECTED_HOME_NAMES[*]:-(none)}"
echo ""

if ! gum confirm "THIS WILL ERASE ALL DATA ON $DISK. Proceed?"; then
  echo "[!] Aborted"
  exit 1
fi

HOST_DIR="hosts/$HOSTNAME"
mkdir -p "$HOST_DIR/users/twostone"

NIXOS_IMPORTS=""
for mod in "${SELECTED_NIXOS_NAMES[@]+"${SELECTED_NIXOS_NAMES[@]}"}"; do
  NIXOS_IMPORTS="${NIXOS_IMPORTS}
    flake.nixosModules.$mod"
done

HOME_IMPORTS=""
for mod in "${SELECTED_HOME_NAMES[@]+"${SELECTED_HOME_NAMES[@]}"}"; do
  HOME_IMPORTS="${HOME_IMPORTS}
    flake.homeModules.$mod"
done

cat > "$HOST_DIR/configuration.nix" <<CONF
{
  inputs,
  flake,
  hostName,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    { _module.args.mainDisk = "$DISK"; }
    ./disks.nix

    inputs.nixos-facter-modules.nixosModules.facter
    { config.facter.reportPath = ./facter.json; }

    flake.nixosModules.common-base${NIXOS_IMPORTS}

    flake.nixosModules.users-twostone
  ];

  home-manager.useGlobalPkgs = true;
  networking.hostName = "$HOSTNAME";
  sops.age.generateKey = false;
  system.stateVersion = "25.05";
}
CONF

cat > "$HOST_DIR/disks.nix" <<'DISKS'
{
  lib,
  config,
  mainDisk ? "/dev/vda",
  ...
}:
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = mainDisk;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2000M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
DISKS

cat > "$HOST_DIR/users/twostone/home-configuration.nix" <<HOMECONF
{
  flake,
  inputs,
  ...
}:
{
  imports = [
    flake.homeModules.hostname
    flake.homeModules.common-base${HOME_IMPORTS}

    flake.homeModules.users-twostone-common
  ];

  home.stateVersion = "25.05";
  custom.hostname = "$HOSTNAME";
}
HOMECONF

echo ""
echo "[*] Generating hardware configuration..."
nixos-generate-config --no-filesystems --show-hardware-config > "$HOST_DIR/hardware-configuration.nix" 2>/dev/null || true

echo "[*] Generating hardware report..."
nixos-facter > "$HOST_DIR/facter.json" 2>/dev/null || touch "$HOST_DIR/facter.json"

git add "$HOST_DIR"
git commit -q -m "Add host $HOSTNAME"

echo ""
echo "[*] Partitioning $DISK..."
disko --mode zap_create_mount --argstr mainDisk "$DISK" "$HOST_DIR/disks.nix"

echo "[*] Deploying sops age key..."
mkdir -p /mnt/var/lib/sops-nix
KEY_DEPLOYED=false
if [[ -n "$SOPS_KEY" && -f "$SOPS_KEY" ]]; then
  cp "$SOPS_KEY" /mnt/var/lib/sops-nix/key.txt
  chmod 600 /mnt/var/lib/sops-nix/key.txt
  echo "[ok] Key deployed from $SOPS_KEY"
  KEY_DEPLOYED=true
else
  KEY_FILE=$(gum input --prompt "Path to sops age key (or press Enter to skip): " --placeholder "/media/usb/keys.txt")
  if [[ -n "$KEY_FILE" && -f "$KEY_FILE" ]]; then
    cp "$KEY_FILE" /mnt/var/lib/sops-nix/key.txt
    chmod 600 /mnt/var/lib/sops-nix/key.txt
    echo "[ok] Key deployed from $KEY_FILE"
    KEY_DEPLOYED=true
  fi
fi
if [[ "$KEY_DEPLOYED" != true ]]; then
  echo "[!] No sops key deployed. Sops secrets will NOT decrypt until you manually place"
  echo "    your age private key at /var/lib/sops-nix/key.txt and rebuild."
fi

echo "[*] Setting up config in home directory..."
mkdir -p /mnt/home/twostone
cp -a "$WORK_DIR" /mnt/home/twostone/nixos-config
chown -R 1000:100 /mnt/home/twostone/nixos-config

echo ""
echo "[*] Installing NixOS (this will take a while)..."
nixos-install --flake ".#$HOSTNAME" --no-root-passwd

echo ""
echo "Installation complete!"
echo "Reboot with: reboot"
