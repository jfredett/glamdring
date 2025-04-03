{ config, pkgs, lib, nur, ... }:
{
  imports = [
    ./barrier
    ./bash
    ./direnv
    ./dirstack
    ./discord
    ./firefox
    ./git
    ./ghostty
    ./hyprland
    ./kitty
    ./kubernetes
    ./nixvim
    ./realise-symlink
    ./slack
    ./ssh
    ./tmux
    ./virt-manager
  ];

  config = {
    nixpkgs.config.allowUnfree = true;
  };
}
