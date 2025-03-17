{
  pkgs,
  inputs,
  systemSettings,
  userSettings,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true; # Install packages to /etc/profiles
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs systemSettings userSettings;
    };
    users.${userSettings.username} = {
      imports = [ ./../home ];
      home.username = "${userSettings.username}";
      home.homeDirectory = "/home/${userSettings.username}";
      home.stateVersion = "${systemSettings.stateVersion}";
      programs.home-manager.enable = true;
      accounts.email.accounts = userSettings.emailAccounts;
    };
  };

  users.mutableUsers = false;
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "${userSettings.username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "${userSettings.hashedPassword}";
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = [ "${userSettings.username}" ];
}
