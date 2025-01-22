{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.ghostty = {
      enable = mkEnableOption "Enable the ghostty terminal emulator";
    };
  };

  config = let
    cfg = config.glamdring.ghostty;
    # NOTE: https://github.com/ghostty-org/ghostty/discussions/3800 explains why this is here. In short,
    # `ghostty` needs to be signed, that's nontrivial, work underway, but no ETA.
    condition = pkgs.stdenv.isLinux && cfg.enable;
  in mkIf condition {
      home.packages = [ pkgs.ghostty ];

      xdg = {
        enable = true;
        configFile."ghostty/config" = {
          text = ''
          # ghostty.conf

          font-feature = -calt
          font-feature = -dlig
          font-feature = -liga
          '';
        };
      };
    };
}
