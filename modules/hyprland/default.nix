{ config, pkgs, lib, hyprland, ... }: with lib; let
in {
  options = {
    glamdring.hyprland = with types; {
      enable = mkEnableOption "Enable hyprland";
    };
  };

  config = let
    cfg = config.glamdring.hyprland;
    condition = cfg.enable;
  in mkIf condition {
    wayland.windowManager = {
      hyprland = {
        enable = true;
        settings = {
          "$mod" = "SUPER";
          monitor = [
            "M1, 2560x1440, 0x0, 1"
          ];
          bind = [
            "$mod, Return, alacritty"
          ];
        };
      };
    };
  };
}
