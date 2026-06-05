{
  inputs,
  flake,
  hostName,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    # Add SSH public keys for headless installation:
    # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA..."
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFsZLGKAJdFvd76p74eJpZQwvSXTGpdIwhnYSfHbi+cU"
  ];

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "nixos";
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    git
    curl
    jq
    gum
    vim
    inputs.disko.packages.x86_64-linux.default
    (pkgs.writeShellScriptBin "nixos-installer" (builtins.readFile ./installer.sh))
  ];

  isoImage.contents = [
    {
      source = lib.cleanSourceWith {
        src = ./../..;
        filter = path: type:
          let
            name = baseNameOf path;
            in
          name != ".git"
            && name != ".direnv"
            && name != ".envrc"
            && name != "keys.txt"
            && name != "secrets.yaml"
            && !(lib.hasPrefix "result" name);
      };
      target = "/nixos-config";
    }
  ];

  system.stateVersion = "25.05";
}
