{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.rust = {
      enable = mkEnableOption "Enable the module";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.rust;
    condition = cfg.enable;
  in mkIf condition {
      home.packages = with pkgs; [
        lldb
      ];

      programs.nixvim = {
        plugins.rustaceanvim = {
          enable = true;
        };
      };
    };
}
