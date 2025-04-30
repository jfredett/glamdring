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
            manix.enable = true;
          };
          settings = {
            defaults = {
              file_ignore_patterns = [
                "%.lock"
                "%.out"
                "^.git/"
                "^.mypy_cache/"
                "^__pycache__/"
                "^output/"
                "^data/"
                "%.ipynb"
              ];
            };
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

