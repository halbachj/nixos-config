{
  inputs,
  pkgs,
  host,
  systemSettings,
  ...
}:
{
  home.packages = (
    with pkgs; [ 
        #inputs.zen-browser.packages."${systemSettings.system}".default
        firefox-devedition 
    ]
  );
}
