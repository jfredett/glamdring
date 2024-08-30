{ config, lib, pkgs, ...}: {
  imports = [
    ./azure-aliases.nix
  ];

  options.glamdring.bash = {
    enable = lib.mkEnableOption "Enable bash configuration";
  };

  config = lib.mkIf config.glamdring.bash.enable {
    home.packages = [ pkgs.oh-my-posh ];

    programs.bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;

      initExtra = ''
        set -o vi
        export EDITOR=nvim
      '';

      shellAliases = {
        "cd.." = "cd ..";
        psf = "ps aux | grep";
        rg = "rg --no-ignore";
        vi = "nvim";
        vim = "nvim";
      };
    };

    programs.oh-my-posh = {
      enable = true;
      useTheme = "atomicBit";
      # TODO: Custom Theme
    };
  };
}
