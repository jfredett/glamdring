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
    ./hyprland
    ./nixvim
    ./realise-symlink
    ./slack
    ./ssh
    ./tmux
    ./virt-manager
  ];

  nixpkgs.config.allowUnfree = true;
}
