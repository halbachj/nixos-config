{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [ wl-clipboard ];
    settings = {
      theme = "onedark";

      editor = {
        auto-completion = true;
        auto-format = true;
        line-number = "relative";
        cursorline = true;
        soft-wrap.enable = true;
      };
    };
  };
}
