{ pkgs, input, ... }: {

  environment.systemPackages = [
    self.packages.${pkgs.stdenv.system}.neovim
  ];

}
