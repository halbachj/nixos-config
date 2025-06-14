{
  inputs,
  flake,
  hostName,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    { _module.args.disk = "/dev/nvme0n1"; }
    { _module.args.mount-disk = "/dev/mapper/cryptroot"; }
    ./disks.nix

    inputs.nixos-facter-modules.nixosModules.facter
    { config.facter.reportPath = ./facter.json; }
    
    flake.nixosModules.common-base
    flake.nixosModules.desktop-base
                #flake.nixosModules.desktop-base-extra
    flake.nixosModules.desktop-sway

    flake.nixosModules.users-twostone
  ];

  networking.hostName = "feather";
  system.stateVersion = "25.05";
}
