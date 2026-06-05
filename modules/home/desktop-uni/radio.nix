{
  inputs,
  pkgs,
  system,
  ...
}:
{

  home.packages = with pkgs; [
    gnuradio
    #gqrx-portaudio
  ];

}
