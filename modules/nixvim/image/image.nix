{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.image = {
      enable = mkEnableOption "Enable the module";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.image;
    condition = cfg.enable;
  in mkIf condition {
      home.packages =  with pkgs; [
        imagemagick
        luajitPackages.magick
      ];

      programs.nixvim = {
        plugins.image = {
          enable = true;
          settings = {
            backend = "kitty";
          };
        };
      };
    };
}
