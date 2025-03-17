{
  self,
  pkgs,
  lib,
  inputs,
  systemSettings,
  ...
}:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  nixpkgs = {
    overlays = [ inputs.nur.overlays.default ];
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    uutils-coreutils-noprefix
    ripgrep
  ];

  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.locale;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = systemSettings.stateVersion;
}
