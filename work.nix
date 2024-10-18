{ config, pkgs, ... }: {

  imports = [
    ./modules
  ];

  glamdring = {
    alacritty.enable = true;
    barrier = {
      enable = false;
      server = "hedges.canon";
    };
    bash = {
      enable = true;
      posh-theme = "cloud-native-azure";
      aliases = {
        azure.enable = true;
      };
    };
    direnv.enable = true;
    dirstack.enable = false;
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
      agrolens.enable = true;
      rust = {
        enable = true;
        bacon.enable = true;
      };
      copilot.enable = false;
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
    ripgrep
    dig
    nmap
    htop
    netcat
    tree
    jq
    yq
    inetutils
  ];

  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };
}
