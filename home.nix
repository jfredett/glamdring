{ config, pkgs, lib, ... }:
{
  home.stateVersion = "22.11";

  home.packages = [
    pkgs.rnix-lsp
    pkgs.ripgrep
  ];

/*
  imports = [
    ./bash.nix
    ./dirstack.nix
    ./git.nix
    ./nvim.nix
    ./ssh.nix
    ./tmux.nix
  ];
  */

  programs = {
    home-manager.enable = true;
    bash.enable = true;
    git.enable = true;
 #   neovim.enable = true;
#    tmux.enable = true;
 #  ssh.enable = true;
 #   direnv = {
 #     enable = true;
 #     nix-direnv.enable = true;
 #   };
  };
}