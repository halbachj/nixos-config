{ pkgs, lib, ... }:
{
  programs.dconf.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      l    = "ls -alh";
      ll   = "ls -l";
      ls   = "ls --color=tty";
      calc = "octave";
    };
  };

  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "fino"; 
    plugins = [ "git" "sudo" "docker" "kubectl" ];
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # pinentryFlavor = "";
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];
}
