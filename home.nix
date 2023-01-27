{ config, pkgs, lib, ... }:
{
  home.stateVersion = "22.11";

  home.packages = [
    pkgs.rnix-lsp
    pkgs.ripgrep
  ];

  imports = [
    ./bash.nix
    ./dirstack.nix
    ./git.nix
    ./nvim.nix
    ./ssh.nix
    ./tmux.nix
  ];
  
  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };

  programs = {
    home-manager.enable = true;
    bash.enable = true;
    git.enable = true;
    neovim.enable = true;
    tmux.enable = true;
    ssh.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}