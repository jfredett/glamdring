# Bespoke config for running on a netbootable machine (like dragon-of-perdition).
{ pkgs, ... }: {

  imports = [
    ./modules
  ];

  glamdring = {
    bash = {
      enable = true;
      posh-theme = "tiwahu";
    };
    deskflow = {
      enable = true;
      server = "hedges.canon";
    };
    direnv.enable = true;
    dirstack.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      identity = {
        name = "Joe Fredette";
        email = "jfredett@gmail.com";
      };
    };
    # hyprland.enable = true;
    kitty.enable = true;
    kubernetes.enable = true;
    nixvim = {
      enable = true;
      colorscheme = "melange";

      lean.enable = true;
      modelica.enable = true;
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
    tmux.enable = false;

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
    clang
    dig
    htop
    hyperfine
    jq
    lsof
    mprocs
    netcat
    nmap
    pciutils
    ripgrep
    rusty-man
    sysstat
    tree
    xh
    yazi
    yq
  ];

  home.shellAliases = {
    ps1 = "true"; # no-opping this since I can't figure out where it's being set outside of nix. Non-nixos makes me sad.
  };
}
