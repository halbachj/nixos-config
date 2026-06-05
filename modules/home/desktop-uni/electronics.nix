{
  inputs,
  pkgs,
  system,
  ...
}:
{

  home.packages = with pkgs; [
    qucs-s 
    ngspice

    nanovna-saver

    mission-planner
  ];

}
