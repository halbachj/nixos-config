{
  description = "TwoStones nixos configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nur.url = "github:nix-community/NUR";

    systems.url = "github:nix-systems/default";
    blueprint = {
      url = "github:numtide/blueprint";
      inputs.systems.follows = "systems";
    };

    nixos-facter-modules = {
      url = "github:nix-community/nixos-facter-modules";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anvim = {
      url = "github:halbachj/anvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-matlab-fork = {
      url = "github:james-atkins/nixpkgs/pr/matlab";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    cursor = {
      url = "github:omarcresp/cursor-flake/main";
    };

  };
  outputs =
    inputs:
    let
      nixpkgs-fork-overlay =
        final: prev:
        let
          # bring in the helper + tool from the fork
          fetchFromMPM = final.callPackage (
            inputs.nixpkgs-matlab-fork + "/pkgs/by-name/ma/matlab-package-manager/fetcher.nix"
          ) { };

          matlab-package-manager = final.callPackage (
            inputs.nixpkgs-matlab-fork + "/pkgs/by-name/ma/matlab-package-manager/package.nix"
          ) { };
        in
        {
          inherit fetchFromMPM matlab-package-manager;

          # now the main package can resolve its deps
          matlab = final.callPackage (inputs.nixpkgs-matlab-fork + "/pkgs/by-name/ma/matlab/package.nix") {
            inherit fetchFromMPM matlab-package-manager;
          };
        };
    in
    inputs.blueprint {
      inherit inputs;
      nixpkgs = {
        # Load overlays
        overlays = [
          inputs.nur.overlays.default
          nixpkgs-fork-overlay
        ];
        # Pretty standard stuff set by default, but making it explicit
        config = {
          allowBroken = false;
          allowUnsupportedSystem = false;
          allowUnfree = true;
        };
      };
    };
}
