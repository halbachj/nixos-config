{
  inputs,
  flake,
  hostName,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    { _module.args.diskA = "/dev/disk/by-id/nvme-KBG6AZNT256G_LA_KIOXIA_ZEUPS18TZ2B3"; }
    { _module.args.diskB = "/dev/disk/by-id/nvme-WD_BLACK_SN770_1TB_25020K800662"; }
    ./disks.nix

    inputs.nixos-facter-modules.nixosModules.facter
    { config.facter.reportPath = ./facter.json; }

    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd

    flake.nixosModules.common-base
    flake.nixosModules.desktop-base
    flake.nixosModules.desktop-base-extra
    flake.nixosModules.laptop-base
    flake.nixosModules.desktop-sway
    flake.nixosModules.desktop-uni

    flake.nixosModules.server-docker

    flake.nixosModules.desktop-games

    flake.nixosModules.opencode-secrets

    flake.nixosModules.users-twostone
    flake.nixosModules.users-twostone-sops-pass
  ];

  hardware.rtl-sdr.enable = true;

  home-manager.useGlobalPkgs = true;
  hardware.enableAllFirmware = true;
  networking.hostName = "feather";
  system.stateVersion = "25.05";
}
