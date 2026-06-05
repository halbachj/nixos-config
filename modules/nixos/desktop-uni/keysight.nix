{ pkgs, inputs, ... }:
{
  services.udev.extraRules = ''
    # Keysight/Agilent/HP instruments
    SUBSYSTEM=="usb", ATTR{idVendor}=="2a8d", MODE="0660", GROUP="plugdev"
  '';

}
