{ config, home-manager, lib, pkgs, ... }:
{

  imports = [
    ./modules
  ];

  glamdring = {
    alacritty.enable = true;
    barrier.enable = false;
    bash.enable = true;
    direnv.enable = false;
    dirstack.enable = false;
    discord.enable = false;
    firefox.enable = true;
    git.enable = false;
    nixvim.enable = false;
    slack.enable = false;
    ssh.enable = true;
    tmux.enable = false;
    virt-manager.enable = false;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
  ];

  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };
}
