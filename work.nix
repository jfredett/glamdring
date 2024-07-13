{ config, pkgs, ... }: {

  imports = [
    ./modules
  ];

  glamdring = {
    alacritty.enable = true;
    barrier = {
      enable = true;
      server = "hedges.pandemon.ium";
    };
    bash.enable = true;
    direnv.enable = true;
    dirstack.enable = true;
    discord.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      identity = {
        name = "Joe Fredette";
        email = "jfredette@merative.com";
      };
    };
    nixvim.enable = true;
    slack.enable = true;
    ssh.enable = true;
    tmux.enable = true;
    virt-manager.enable = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

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

  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };
}
