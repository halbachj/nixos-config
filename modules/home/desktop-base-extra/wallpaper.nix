{
  inputs,
  pkgs,
  system,
  ...
}:
{
  home.packages = with pkgs; [
    variety
  ];
}
