{ pkgs, inputs, systemSettings, ... }:

let
  anvim = inputs.anvim.packages.${systemSettings.system}.default;
in {
  home.packages = [ anvim ];

  programs.neovim = {
    defaultEditor = true;
  };
}

