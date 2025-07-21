{ pkgs, ... }:
{
  programs.helix = {
    extraPackages = with pkgs; [ typos-lsp ];
    languages.language-server.typos-lsp.command = "typos-lsp";
  };
}

