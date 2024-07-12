{ config, pkgs, lib, nur, ... }:
{
  imports = [
    ./_1password
    ./virtualbox
  ];

  nixpkgs.config.allowUnfree = true;
}
