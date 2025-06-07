{
  description = "TwoStones nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
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

    anvim = {
      url = "github:halbachj/anvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        timezone = "Europe/Dublin"; # select timezone
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
	emailAccounts = {
	  halbachnet = {                      
	    primary = true;
      	    userName = "johannes@halbachnet.de";
            realName = "Johannes Halbach"; 
            address = "johannes@halbachnet.de";
            flavor = "plain";             
            imap.host = "imap.1und1.com";      
            imap.port = 993;              
            smtp.host = "smtp.1und1.com";      
            smtp.port = 465;              
            thunderbird.enable = true;
	  };
        };                             
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
