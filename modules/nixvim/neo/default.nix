{ config, pkgs, lib, nur, ... }:
{
  imports = [
    ./test.nix
    ./tree.nix
    ./git.nix
  ];

  config = { };
}
