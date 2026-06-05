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
    sage # NOTE: Currently broken
    speedcrunch
    geogebra6
    mathematica
  ];

}
