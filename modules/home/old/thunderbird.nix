{ inputs, pkgs, ... }: {
  programs.thunderbird = {
    enable = true;
    profiles = {
      halbachnet.isDefault = true;     
    };
  };
}
