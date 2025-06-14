{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.obsidian = {
      enable = mkEnableOption "Enable the module";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.obsidian;
    condition = cfg.enable;
  in mkIf condition {
      programs.nixvim = {
        plugins.obsidian = {
          enable = true;
          # settings = { };
        };
      };
    };
}
