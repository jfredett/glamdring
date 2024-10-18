{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.rust.bacon = {
      enable = mkEnableOption "Enable the module";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.bacon;
    condition = cfg.enable;
  in mkIf condition {
      programs.nixvim = {
        plugins.bacon = {
          enable = true;
        };
      };
  };
}
