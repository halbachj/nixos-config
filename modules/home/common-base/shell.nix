{
  pkgs,
  config,
  lib,
  ... 
}:
{
  home.sessionVariables = {
    PATH = "$HOME/.local/bin:$PATH";
  };

  home.packages = with pkgs; [
    ripgrep
    zsh-powerlevel10k
    pay-respects
    (lib.hiPrio uutils-coreutils-noprefix)
  ];

  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.stateHome}/bash/bash_history";
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        l     = "ls -alh";
        ll    = "ls -l";
        ls    = "ls --color=tty";
        calc  = "octave";
        nos   = "nh os switch";
        nob   = "nh os build";
      };
      initContent = lib.mkOrder 1500 ''
        eval "$(zoxide init zsh)"
        eval "$(pay-respects zsh --alias)"
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ~/.p10k.zsh

        cheat() {
          curl -s "https://cheat.sh/$1"
        }
      '';
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
      #initExtra = "source ~/.p10k.zsh";

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "docker" "kubectl" "dirhistory" "history" ];
      };
    };
  };
  programs.ghostty.enableZshIntegration = true;
  home.file.".p10k.zsh".text = builtins.readFile ./.p10k.zsh;
}
