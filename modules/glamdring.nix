{ config, lib, pkgs, nur, ...}: {
  imports = [
    ./common.nix

    ./1password
    ./alacritty
    ./barrier
    ./bash
    ./direnv
    ./dirstack
    ./discord
    ./dropbox
    ./firefox
    ./git
    ./nixvim
    ./slack
    ./ssh
    ./tmux
    ./users
    ./virt-manager
    ./virtualbox
  ];

  glamdring.users.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
