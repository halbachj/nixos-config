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
    fzf
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

    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      dotDir = "${config.home.homeDirectory}/.zsh";
      shellAliases = {
        l = "ls -alh";
        ll = "ls -l";
        ls = "ls --color=tty";
        calc = "octave";
        nos = "nh os switch";
        nob = "nh os build";
        cpath = "pwd | wl-copy";
        matd = "matlab -nodesktop";
        td = "todoist";
        tdl = "todoist l";
        tdc = "todoist complete";
        tda = "todoist add";
        tdap = "todoist add -P ";
        tdeo = "todoist add -N DUSAC-EO";
        tdac = "todoist add -N College";
        tdp = "todoist projects";
        tdd = "todoist delete";
        tds = "todoist sync";
        tdq = "todoist quick";
      };
      initContent = lib.mkOrder 1500 ''
        eval "$(zoxide init zsh)"
        eval "$(pay-respects zsh --alias)"
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ~/.p10k.zsh

        if [ -n "$\{commands[fzf-share]\}" ]; then
          source "$(fzf-share)/key-bindings.zsh"
          source "$(fzf-share)/completion.zsh"
        fi

        # Remote path completion for scp/sftp/rsync
        zstyle ":completion:*:(scp|sftp|rsync):*" remote-access yes

        # Optional: cache completions (faster subsequent tabs)
        if [[ -z $ZSH_CACHE_DIR- ]]; then
          ZSH_CACHE_DIR=$XDG_CACHE_HOME:-$HOME/.cache/zsh
        fi
        mkdir -p "$ZSH_CACHE_DIR"
        zstyle ":completion:*" use-cache on
        zstyle ":completion:*" cache-path "$ZSH_CACHE_DIR"

        # MATLAB wrapper function
        matlab() {
          distrobox-enter -n matlab -- /usr/local/mathworks/bin/matlab "$@"
        }
      '';
      sessionVariables = {
        POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD = true;
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
        plugins = [
          "git"
          "sudo"
          "docker"
          "kubectl"
          "dirhistory"
          "history"
        ];
      };
    };
  };
  programs.ghostty.enableZshIntegration = true;
  home.file.".p10k.zsh".text = builtins.readFile ./.p10k.zsh;
}
