{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.lean = {
      enable = mkEnableOption "Enable support for the lean theorem prover";
    };
  };

  config = let
    cfg = config.glamdring.nixvim.lean;
    condition = cfg.enable;
  in mkIf condition {
      home.packages = with pkgs; [
        lean4
        # elan
      ];

      programs.nixvim = {
        plugins.lean = {
          enable = true;
          settings = {
            abbreviations = {
              enable = true;
              extra = {
                wknight = "♘";
              };
            };
            ft = {
              default = "lean";
              nomodifiable = [
                "_target"
              ];
            };
            infoview = {
              horizontal_position = "top";
              indicators = "always";
              separate_tab = true;
            };
            lsp = {
              enable = true;
            };
            mappings = false;
            progress_bars = {
              enable = false;
            };
            stderr = {
              on_lines = {
                __raw = "function(lines) vim.notify(lines) end";
              };
            };
          };
        };
      };
    };
}
