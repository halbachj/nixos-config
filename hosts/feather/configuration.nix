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
    { _module.args.diskB = "/dev/disk/by-id/nvme-eui.0000000001000000e4d25ca10ea75101"; }
    ./disks.nix

    inputs.nixos-facter-modules.nixosModules.facter
    { config.facter.reportPath = ./facter.json; }
    
    flake.nixosModules.common-base
    flake.nixosModules.desktop-base
                #flake.nixosModules.desktop-base-extra
    flake.nixosModules.laptop-base
    flake.nixosModules.desktop-sway

    flake.nixosModules.desktop-games

    flake.nixosModules.users-twostone
  ];

  networking.hostName = "feather";
  system.stateVersion = "25.05";
}
