{ pkgs, ... }:
{
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        #cnijfilter2
        hplip
      ];
    };
  };
}
