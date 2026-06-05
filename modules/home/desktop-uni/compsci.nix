{
  inputs,
  pkgs,
  system,
  ...
}:
{

  home.packages = with pkgs; [
    terraform
    ghidra
  ];

}
