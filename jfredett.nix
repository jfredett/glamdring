{ config, pkgs, lib, nixvim, ... }:
{
  home.stateVersion = "22.11";

  home.packages = [
    pkgs.ripgrep
  ];

  imports = [
    nixvim.homeManagerModules.nixvim
    ./bash.nix
    ./dirstack.nix
    ./git.nix
    ./nixvim.nix
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
    nixvim.enable = true;
    tmux.enable = true;
    ssh.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
