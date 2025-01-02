{ pkgs, ... }: {

  imports = [
    ./modules
  ];

  glamdring = {
    bash = {
      enable = true;
      posh-theme = "negligible";
    };
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

      avante.enable = true;
      copilot.enable = false;

      rust = {
        enable = true;
        debugger = {
          enable = true;
          using = "codelldb";
        };
        bacon.enable = true;
      };

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
