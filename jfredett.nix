{ pkgs, home-manager, nixvim, nur, ... }:
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    ripgrep
    tree
  ];

  imports = [
    ./barrier.nix
    ./bash.nix
    ./direnv.nix
    ./dirstack.nix
    ./discord.nix
    ./dropbox.nix
    ./firefox.nix
    ./git.nix
    ./nixvim.nix
    ./slack.nix
    ./ssh.nix
    ./tmux.nix
    ./virt-manager.nix
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
  };
}
