{ ... }: {

services.pipewire = {
  enable = true;
  pulse.enable = true;
  jack.enable = true;
  audio.enable = true;
  alsa = {
    enable = true;
    support32Bit = true;
  };
 };
}
