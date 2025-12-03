{ config, pkgs, lib, nur, ... }:
{
  imports = [
    ./bash
    ./deskflow
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
    ./signal
    ./ssh
    ./tmux
    ./virt-manager
  ];

  config = {
    nixpkgs.config.allowUnfree = true;
  };
}
