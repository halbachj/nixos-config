{ pkgs, ... }:
{
  programs.helix = {
    extraPackages = with pkgs; [ ruff black pyright ];
    languages = {
      language = [{
        name            = "python";
        language-servers = [ "pyright" "typos-lsp" ];
        formatter       = { command = "black"; args = [ "-" ]; };
        roots           = [ ".git" "pyproject.toml" ];
      }];
      language-server.pyright.command = "pyright-langserver";
      language-server.pyright.args    = [ "--stdio" ];
      language-server.ruff.command    = "ruff";
      language-server.ruff.args       = [ "server" ];
    };
  };
}

