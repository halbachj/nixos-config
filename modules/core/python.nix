{ pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [
    python313
    python313Packages.pyserial
    python312
    python312Packages.pwntools
  ];
}
