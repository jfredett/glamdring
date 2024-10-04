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
              # TODO: Would be nicer if this were smarter and looked for a coverage
              # file by a few names, and noops when it can't find one.
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
