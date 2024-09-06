{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.kitty = {
      enable = mkEnableOption "Enable the kitty terminal emulator";
      stylix.enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Enable the Stylix theme for kitty.
        '';
      };
    };
  };

  config = let
    cfg = config.glamdring.kitty;
    condition = cfg.enable;
  in mkIf condition {
    home.packages = [ pkgs.kitty ];
    stylix.targets.kitty.enable = cfg.stylix.enable;
  };
}
