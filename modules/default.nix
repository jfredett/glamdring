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
    ./kitty
    ./nixvim
    ./realise-symlink
    ./slack
    ./stylix
    ./ssh
    ./tmux
    ./virt-manager
  ];

  config = {
    nixpkgs.config.allowUnfree = true;
  };
}
