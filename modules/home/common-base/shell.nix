{
  pkgs,
  config,
  lib,
  ... 
}:
{
  home.packages = with pkgs; [
    ripgrep
    (lib.hiPrio uutils-coreutils-noprefix)
  ];

  programs.zsh = {
    enable = true;
    #shellInit = ''
    #  cheat() {
    #    curl cheat.sh/"$1"
    #  }
    #'';
    shellAliases = {
      l     = "ls -alh";
      ll    = "ls -l";
      ls    = "ls --color=tty";
      calc  = "octave";
    };
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "fino";
    plugins = [ "git" "sudo" "docker" "kubectl" ];
  };
}
