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
      programs.nixvim = {
        plugins.image.enable = true;
      };
  };
}
