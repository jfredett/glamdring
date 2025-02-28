# Bespoke config for running on a netbootable machine (like dragon-of-perdition).
{ pkgs, ... }: {

  imports = [
    ./modules
  ];

  glamdring = {
    bash = {
      enable = true;
      posh-theme = "velvet";
    };
    direnv.enable = true;
    dirstack.enable = true;
    git = {
      enable = true;
      identity = {
        name = "Joe Fredette";
        email = "jfredett@gmail.com";
      };
    };
    nixvim = {
      enable = true;
      colorscheme = "melange";
      rust = {
        enable = true;
        debugger = {
          enable = true;
          using = "codelldb";
        };
        bacon.enable = true;
      };

      code-companion.enable = true;
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

    realise-symlink.enable = true;
    ssh.enable = true;
    tmux.enable = true;
  };


  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    bat
    dig
    htop
    jq
    netcat
    nmap
    ripgrep
    sysstat
    tree
    yq
  ];

  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };
}
