{ inputs, lib, pkgs, flake, ... }:
{
  home.packages = [ inputs.anvim.packages.x86_64-linux.default ];

}

