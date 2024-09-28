{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.coverage = {
      enable = mkEnableOption "Enable the module";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.coverage;
    condition = cfg.enable;
  in mkIf condition {
      programs.nixvim = {
        plugins = {
          coverage = {
            enable = true;
            autoReload = true;
            lcovFile = ".lcov";
          };
        };

        autoCmd = [
          { # Automatic coverage loading for rust
            callback = {
              __raw = ''
                function()
                  require("coverage").load_lcov(".lcov", true)
                end
              '';
            };
            event = [
              "BufEnter"
              "BufWinEnter"
            ];
            pattern = [
              "*.rs"
            ];
          }
        ];
      };
  };
}
