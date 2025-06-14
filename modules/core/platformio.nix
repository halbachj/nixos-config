{ pkgs, input, ... }: {

  environment.systemPackages = with pkgs; [
    platformio
  ];

  services.udev.packages = [ 
    pkgs.platformio-core.udev
    pkgs.platformio-core
    pkgs.openocd
  ];

}
