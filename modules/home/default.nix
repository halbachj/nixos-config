{inputs, userSettings, host, ...}:
{
  imports = [
    ./sway.nix
    ./discord/discord.nix
    ./browser.nix
    ./rofi.nix
    ./ghostty.nix
    ./anvim.nix
    ./spicetify.nix
    ./git.nix
    ./fonts.nix
    ./thunderbird.nix
    ./i3status-rs.nix
    ./latex.nix
    ./jetbrains.nix
    ./programs.nix

    ./xdg.nix
  ];
}
