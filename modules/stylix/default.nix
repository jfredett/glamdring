{ config, lib, pkgs, stylix, ...}: with lib; {

  options = {
    glamdring.stylix = with types; {
      enable = mkEnableOption "Enable Stylix";
    };
  };

  config = let
    cfg = config.glamdring.stylix;
    condition = cfg.enable;
  in {
    stylix = mkIf condition {
      enable = false;
      image = ../../assets/wallpapers/ai/garage-lab-1.png;
      polarity = "dark";
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.inconsolata;
          name = "Inconsolata Nerdfont";
        };
      };
    };
  };
}
