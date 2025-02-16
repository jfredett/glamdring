{ config, lib, pkgs, ...}: {
  imports = [
    ./azure-aliases.nix
  ];

  options.glamdring.bash = {
    enable = lib.mkEnableOption "Enable bash configuration";
    posh-theme = lib.mkOption {
      type = lib.types.str;
      default = "atomicBit";
      description = "The oh-my-posh theme to use";
    };
  };

  config = lib.mkIf config.glamdring.bash.enable {
    home.packages = [
      pkgs.oh-my-posh
      pkgs.bat
    ];

    programs.bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;

      initExtra = ''
        set -o vi
        export EDITOR=nvim
        export DO_NOT_TRACK=1
      '';

      shellAliases = {
        "cd.." = "cd ..";
        psf = "ps aux | grep";
        rg = "rg --no-ignore";
        vi = "nvim";
        vim = "nvim";
        cat = "bat";
      };
    };

    programs.oh-my-posh = {
      enable = true;
      useTheme = config.glamdring.bash.posh-theme;
      # TODO: Custom Theme
    };
  };
}
