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
    home.packages = [ pkgs.kitty ];

    wayland.windowManager = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd.enable = true;

        settings = {
          "$mod" = "SUPER";
          monitor = [
            "M1, 2560x1440, 0x0, 1"
          ];
          bind = [
            "$mod, Return, exec, kitty"
          ];
        };
      };
    };
  };
}
