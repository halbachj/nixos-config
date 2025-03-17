{ pkgs, input, ... }: {

  environment.systemPackages = with pkgs; [
    esptool-ck
  ];

}
