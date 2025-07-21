{ pkgs, ... }:
{
  programs.helix = {
    extraPackages = with pkgs; [ clang-tools ];
    languages.language = [
      {
        name            = "c";
        language-servers = [ "clangd" "typos-lsp" ];
        formatter.command = "clang-format";
        roots           = [ ".git" "CMakeLists.txt" ];
      }
      {
        name            = "cpp";
        language-servers = [ "clangd" "typos-lsp" ];
        formatter.command = "clang-format";
        roots           = [ ".git" "CMakeLists.txt" ];
      }
    ];
  };
}

