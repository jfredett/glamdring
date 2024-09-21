{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    path.to.module = {
      enable = mkEnableOption "Enable the module";
    };
  };

  config = let
    cfg = config.path.to.module;
    condition = cfg.enable;
  in mkIf condition {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        nvim-dap
        nvim-dap-ui
      ];

      plugins.dap = {
        enable = true;
      };
    };

  };
}
