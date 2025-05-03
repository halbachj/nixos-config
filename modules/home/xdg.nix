{ inputs, pkgs, ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen.desktop";
    };
  };
}
