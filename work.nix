{ config, pkgs, ... }: {

  imports = [
    ./modules
  ];

  glamdring = {
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
    kitty.enable = true;
    kubernetes.enable = true;
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
    ssh.enable = true;
    tmux.enable = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [
    (azure-cli.withExtensions [
      azure-cli.extensions.aks-preview
      azure-cli.extensions.oracle-database
      azure-cli.extensions.ssh
    ])
    dbeaver-bin
    dig
    htop
    inetutils
    jq
    mani
    netcat
    nmap
    ripgrep
    tree
    k9s
    watch
    yq
  ];

  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };
}
