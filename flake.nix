{
  description = "TwoStones nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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

  };
  outputs =
    inputs:
    inputs.blueprint {
      inherit inputs;
      nixpkgs = {
        # Load overlays
        overlays = [
        ];
        # Pretty standard stuff set by default, but making it explicit
        config = {
          allowBroken = false;
          allowUnsupportedSystem = false;
          allowUnfree = false;
          # contentAddressedByDefault = true; # Causes too many things to be rebuilt, even with additional caches as above
        };
      };
    };

}
