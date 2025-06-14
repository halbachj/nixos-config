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

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

  };
  outputs =
    inputs:
    inputs.blueprint {
      inherit inputs;
      nixpkgs = {
        # Load overlays
        overlays = [
          inputs.nur.overlays.default
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
