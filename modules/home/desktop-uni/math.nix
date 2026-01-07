{
  inputs,
  pkgs,
  system,
  ...
}:
{

  home.packages = with pkgs; [
    octaveFull
    octavePackages.symbolic
    sage
    speedcrunch
    geogebra6
    mathematica
  ];

}
