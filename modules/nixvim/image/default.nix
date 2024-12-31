{ config, pkgs, lib, nur, ... }:
{
  imports = [
    ./image.nix
  ];

  config = { 
    glamdring.nixvim.image.enable = true;

  };
}
