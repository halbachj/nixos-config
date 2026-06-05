{ ... }:
{
  imports = [
    ./boot.nix
    ./network.nix
    ./console.nix
    ./nix.nix
    ./sudo.nix
    ./nh.nix
    ./misc.nix
    ./time.nix
    ./security.nix
    ./sops.nix
  ];
}
