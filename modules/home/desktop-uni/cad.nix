{
  inputs,
  pkgs,
  system,
  ...
}:
{

  home.packages = with pkgs; [
    #freecad # vtk not compiling
    kicad
  ];

}
