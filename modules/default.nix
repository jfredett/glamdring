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
    ./realise-symlink
    ./slack
    ./ssh
    ./tmux
    ./virt-manager
  ];

  nixpkgs.config.allowUnfree = true;
}
