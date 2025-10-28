{
  inputs,
  pkgs,
  system,
  ...
}:
{

  home.packages = with pkgs; [
    freecad
    kicad
  ];

}
