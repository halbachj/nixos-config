{
  inputs,
  pkgs,
  system,
  ...
}:
{

  home.packages = with pkgs; [
    arduino-core
    arduino-ide
    inputs.nix-xilinx.packages.${pkgs.stdenv.hostPlatform.system}.xilinx-shell
    inputs.nix-xilinx.packages.${pkgs.stdenv.hostPlatform.system}.vivado
    inputs.nix-xilinx.packages.${pkgs.stdenv.hostPlatform.system}.vitis

    (pkgs.writeShellScriptBin "vivado-gui" ''
      exec ${pkgs.nix}/bin/nix --offline develop ${inputs.nix-xilinx}#xilinx-shell --command vivado "$@"
    '')
  ];
}
