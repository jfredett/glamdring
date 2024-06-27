{ config, lib, pkgs, ... }:
{
  options.glamdring.direnv = {
    enable = lib.mkEnableOption "Enable direnv integration";
  };

  programs.direnv = lib.mkIf config.glamdring.direnv.enable {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
