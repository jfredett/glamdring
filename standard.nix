{ pkgs, ... }: {

  imports = [
    ./modules
  ];

  glamdring = {
    barrier = {
      enable = true;
      server = "hedges.canon";
    };
    bash = {
      enable = true;
      posh-theme = "negligible";
    };
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
    kitty.enable = true;
    kubernetes.enable = true;
    ghostty.enable = true;
    nixvim = {
      enable = true;
      colorscheme = "melange";

      code-companion.enable = true;

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
        git.gutter.enable = false; # too slow.
      };
      toggleterm.enable = true;
    };

    realise-symlink.enable = true;
    #stylix.enable = false;
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
    clang
    jq
    yq
    sysstat
  ];

  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };
}
