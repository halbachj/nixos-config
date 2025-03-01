{
  inputs,
  pkgs,
  host,
  systemSettings,
  ...
}:
{

  home.packages = (
    with pkgs;
    [variety]
  );

}
