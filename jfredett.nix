{ pkgs, home-manager, nixvim, nur, ... }:
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    ripgrep
    dig
    nmap
    htop
    netcat
    tree
    jq
    yq
    sysstat
  ];

  imports = [
    ./alacritty.nix
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

  glamdring = {
    alacritty.enable = true;
    git.enable = true;
    bash.enable = true;
    nixvim.enable = true;
    tmux.enable = true;
    ssh.enable = true;
  };
  
  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };

  programs.home-manager.enable = true;

  services.emerald-city = {
    virt-manager.enable = true;
  };
}
