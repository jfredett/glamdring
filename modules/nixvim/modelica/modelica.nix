{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.modelica = {
      enable = mkEnableOption "Enable support for the modelica modeling toolkit";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.modelica;
    condition = cfg.enable;
  in mkIf condition {
      home.packages = with pkgs; [
        openmodelica.combined
      ];

      programs.nixvim = {
        extraPlugins = [
          # lsp, treesitter, etc
        ];

        # config
      };
  };
}
