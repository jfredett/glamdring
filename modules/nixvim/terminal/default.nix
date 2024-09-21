{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.toggleterm = {
      enable = mkEnableOption "Enable the module";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.toggleterm;
    condition = cfg.enable;
  in mkIf condition {
    programs.nixvim = {
      plugins.toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<leader><space><leader>]]";
        };
      };
    };
  };
}

