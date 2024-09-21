{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.cmp = {
      enable = mkEnableOption "Enable the module";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.cmp;
    condition = cfg.enable;
  in mkIf condition {
    programs.nixvim = {
      cmp.enable = true;
    };
  };
}
