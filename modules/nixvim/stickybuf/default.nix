{ config, pkgs, lib, nur, ... }:
{
  imports = [
    ./stickybuf.nix
  ];

  config = {
    glamdring.nixvim.stickybuf.enable = true;
  };
}
