{ config, pkgs, ... }: {

  imports = [
    ./modules
  ];

  glamdring = {
    bash = {
      enable = true;
      posh-theme = "cloud-native-azure";
      aliases = {
        azure.enable = true;
      };
    };
    direnv.enable = true;
    dirstack.enable = false;
    deskflow = {
      enable = true;
      server = "hedges.canon";
    };
    discord.enable = false;
    firefox.enable = false;
    git = {
      enable = true;
      identity = {
        name = "Joe Fredette";
        email = "jfredette@merative.com";
      };
    };
    nixvim = {
      enable = true;
      colorscheme = "gruvbox";
      cmp = {
        enable = true;
        ai.enable = false;
      };
      coverage.enable = true;
      lsp.enable = true;
      neo = {
        tree.enable = true;
        test.enable = true;
      };
      toggleterm.enable = true;
    };
    slack.enable = false;
    ssh.enable = true;
    tmux.enable = true;
    virt-manager.enable = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [
    dig
    dbeaver-bin
    #sqlcl
    htop
    inetutils
    jq
    mani
    netcat
    nmap
    ripgrep
    tree
    yq
  ];

  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };
}
