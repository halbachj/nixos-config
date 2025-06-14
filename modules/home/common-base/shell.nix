{
  pkgs,
  config,
  lib,
  ... 
}:
{
  home.packages = with pkgs; [
    ripgrep
    zsh-powerlevel10k
    (lib.hiPrio uutils-coreutils-noprefix)
  ];

  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.stateHome}/bash/bash_history";
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        l     = "ls -alh";
        ll    = "ls -l";
        ls    = "ls --color=tty";
        calc  = "octave";
      };
      initContent = lib.mkOrder 1500 "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      sessionVariables = {
        POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true;
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}";
          file = "share/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      initExtra = "source ~/.p10k.zsh";

      oh-my-zsh = {
        enable = true;
        #theme = "powerlevel10k/powerlevel10k";
        #plugins = [ "git" "sudo" "docker" "kubectl" "dirhistory" "history" ];
        #custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
      };
    };
  };
  programs.ghostty.enableZshIntegration = true;
  home.file.".p10k.zsh".text = builtins.readFile ./.p10k.zsh;
}
