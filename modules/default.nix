{ config, pkgs, lib, nur, ... }:
{
  imports = [
    ./alacritty
    ./barrier
    ./bash
    ./direnv
    ./dirstack
    ./discord
    ./firefox
    ./git
    ./nixvim
    ./slack
    ./ssh
    ./tmux
    ./virt-manager
  ];

  nixpkgs.config.allowUnfree = true;

}
