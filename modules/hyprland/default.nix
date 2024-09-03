{ config, pkgs, lib, hyprland, stylix, ... }: with lib; let
in {
  options = {
    glamdring.hyprland = with types; {
      enable = mkEnableOption "Enable hyprland";
    }
  };

  config = let
    cfg = config.hyprland;
    condition = cfg.enable;
  in mkIf condition {
    environment.systemPackages = with pkgs; [
      hyprland
      stylix
    ];

    /* this should probably be it's own module, since I will likely use other WMs */
    stylix = {
      enable = true;
      image = ../../../assets/wallpapers/ai/garage-lab-0.png;
    };

  };
}
