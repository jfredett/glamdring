{ config, home-manager, lib, pkgs, ... }:
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
    ./bash.nix
    ./direnv.nix
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

  services.emerald-city = {
    virt-manager.enable = true;
  };
}

}
