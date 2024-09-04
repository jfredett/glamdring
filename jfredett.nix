{ config, pkgs, ... }: {

  imports = [
    ./modules
  ];

  glamdring = {
    alacritty.enable = true;
    barrier = {
      enable = true;
      server = "hedges.canon";
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
        email = "jfredett@gmail.com";
      };
    };
    nixvim = {
      enable = true;
      colorscheme = "kanagawa";
      copilot = true;
    };
    realise-symlink.enable = true;
    slack.enable = true;
    stylix.enable = true;
    ssh.enable = true;
    tmux.enable = true;
    virt-manager = {
      enable = true;
      connections = [
        "qemu+ssh://jfredett@babylon-the-great.canon:22/system?keyfile=/home/jfredett/.ssh/archimedes"
        "qemu+ssh://jfredett@dragon-of-perdition.canon:22/system?keyfile=/home/jfredett/.ssh/archimedes"
      ];
    };
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
