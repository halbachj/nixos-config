{inputs, userSettings, host, ...}:
{
  imports = [
    ./sway.nix
    ./discord/discord.nix
    ./browser.nix
    ./rofi.nix
    ./ghostty.nix
    ./nvim.nix
    ./variety.nix
    ./spicetify.nix
    ./git.nix
  ];
}
