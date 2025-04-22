{ pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [
    octaveFull
  ];
}
