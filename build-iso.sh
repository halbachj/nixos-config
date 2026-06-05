#!/usr/bin/env bash

# Script to built iso

set -euo pipefail

echo "[*] Building NixOS installer ISO..."
nix build .#nixosConfigurations.iso.config.system.build.isoImage

echo ""
echo "[ok] ISO built successfully!"
echo "    Image: result/iso/*.iso"
echo ""
echo "Flash to a USB drive with:"
echo "  sudo dd if=result/iso/nixos-installer.iso of=/dev/sdX bs=4M status=progress && sync"
echo ""
echo "Boot from the USB drive and run:"
echo "  sudo nixos-installer"
echo "  sudo nixos-installer --hostname myhost --disk /dev/nvme0n1"
