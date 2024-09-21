{ config, lib, pkgs, ... }: with lib; {
  config = let
    cfg = config.glamdring.nixvim;
    condition = cfg.colorscheme == "kanagawa";
  in mkIf condition {
    programs.nixvim = {
      colorschemes.kanagawa = {
        enable = true;
        settings = {
          colors = {
            theme = {
              all = {
                bg_gutter = "none";
              };
            };
          };
          commentStyle = {
            italic = true;
          };
          compile = false;
          dimInactive = false;
          functionStyle = { };
          terminalColors = true;
          # FIXME: this doesn't seem to be working.
          theme = "dragon";
          transparent = false;
          undercurl = true;
        };
      };
    };
  };
}
