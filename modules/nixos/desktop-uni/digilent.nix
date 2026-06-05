{ pkgs, inputs, ... }:
let
  digilentAdept = pkgs.callPackage "${inputs.ed-digilent-adept}/digilent-adept.nix" { };
in
{
  boot.blacklistedKernelModules = [ "ftdi_sio" ];

  services.udev.extraRules = ''
    # Xilinx FTDI cable rules (from Vivado), adapted for NixOS
    ACTION=="add", ATTRS{idVendor}=="0403", MODE:="666"

    # Xilinx platform cable rules
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0008", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0007", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0009", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="000d", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="000f", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0013", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0015", MODE="666"
  '';

  environment.systemPackages = [ digilentAdept pkgs.openocd pkgs.xc3sprog ];
  services.udev.packages = [ digilentAdept ];
  environment.etc."digilent-adept.conf".source =
    "${digilentAdept}/etc/digilent-adept.conf";
  environment.etc."udev/rules.d/52-digilent-usb.rules".source =
  "${digilentAdept}/lib/udev/rules.d/52-digilent-usb.rules";
}
