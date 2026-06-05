{
  description = "TwoStones nixos configuration";

  inputs = {
    systems.url = "github:nix-systems/default";
    blueprint = {
      url = "github:numtide/blueprint";
      inputs.systems.follows = "systems";
    };

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-facter-modules = {
      url = "github:nix-community/nixos-facter-modules";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anvim = {
      #url = "github:halbachj/anvim";
      url = "path:/home/twostone/Projects/anvim";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    cursor = {
      url = "github:omarcresp/cursor-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-xilinx = {
      url = "path:/home/twostone/nixos-config/vendor/nix-xilinx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ed-digilent-adept = {
      url = "path:/home/twostone/Projects/ed_digilent_adept";
      flake = false;
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
          # inputs.nix-xilinx.overlays.default
          (final: prev: {
            vivado = prev.vivado.override {
              extraPkgs = pkgs: [ pkgs.ncurses5Compat ];
              # if your nixpkgs uses a different name, try: pkgs.ncurses5Compat
            };
          })
          (final: prev: {
            xorg = prev.xorg // {
              lndir = prev.lndir;
            };
          })
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
