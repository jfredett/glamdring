{ pkgs, nixvim, nur, ... }:
{
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    ripgrep
    tree
  ];

  imports = [
    ./alacritty.nix
    ./barrier.nix
    ./bash.nix
    ./dirstack.nix
    ./discord.nix
    ./firefox.nix
    ./git.nix
    ./nixvim.nix
    ./slack.nix
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
