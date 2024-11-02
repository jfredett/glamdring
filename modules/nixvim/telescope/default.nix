{ config, lib, pkgs, ... }: with lib; {
  config = let
    cfg = config.glamdring.nixvim;
    condition = cfg.enable;
  in mkIf condition {
      programs.nixvim = {
        plugins.telescope = {
          enable = true;
          extensions = {
            frecency.enable = true;
            undo.enable = true;

          };
          settings = {
            pickers = {
              find_files = {
                # no_ignore = true;
              };

            };
          };
        };
      };
    };
}

