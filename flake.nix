{
  description = "TwoStones nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

		
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


    nvf.url = "github:notashelf/nvf";
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        timezone = "Europe/Berlin"; # select timezone
        locale = "en_US.UTF-8"; # select locale
        keymap = "de"; # console key map
        stateVersion = "24.11";
	system = "x86_64-linux";
      };

      #pkgs = import nixpkgs {
      #  inherit system;
      #  config.allowUnfree = true;
      #};

      # ----- USER SETTINGS ----- #
      userSettings = rec {
        username = "twostone"; # username
        name = "Johannes"; # name/identifier
        email = "johannes@halbachnet.de"; # email (used for certain configurations)
        hashedPassword = "$6$eO9zT8YVzpR.Z1Eg$nnBg9ryZgmcXYzc9gdgEdWDFvSNgTysLo2HO0NGafk0RGi8PpyigVwtiwBTG1Z/0Rm9lWPTeLzbixLrdhkwsA/";
      };
      lib = nixpkgs.lib;
      in {
        nixosConfigurations = {
	  stone = nixpkgs.lib.nixosSystem {
	    modules = [ ./hosts/stone ];
	    specialArgs = {
	      inherit self inputs systemSettings userSettings;
	      host = "stone";
            };
          };
        };
      };
}
