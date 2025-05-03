{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [ "spotify" ];

  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    experimentalFeatures = true;
    enabledExtensions = with spicePkgs.extensions; [
      fullScreen
      shuffle # shuffle+ (special characters are sanitized out of extension names)
      queueTime
      simpleBeautifulLyrics
    ];

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      lyricsPlus
    ];

    spotifyLaunchFlags = "--enable-chrome-runtime";

    #theme = spicePkgs.themes.turntable;

    enabledSnippets = [
      ".player-controls .playback-progressbar::before { content: ''; width: 32px; height: 32px; bottom: calc(100% - 7px); right: 10px; position: absolute; image-rendering: pixelated; background-size: 32px 32px; background-image: url('https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZzdsM2Y2aHh3cTQ2Z3JzbXAzMXJrZjdiM3IwMXhnaTFnc295ZnRkZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/cCOVfFwDI3awdse5A3/giphy.gif'); }"
    ];
    # colorScheme = "gruvbox-material-dark";
  };
}
