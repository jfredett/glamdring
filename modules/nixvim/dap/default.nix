{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.dap = {
      enable = mkEnableOption "Enable the module";
      debuggers = {
        gdb.enable = mkEnableOption "Enable gdb";
      };
      virtualText = mkOption {
        type = types.bool;
        default = true;
        description = "Enable virtual text";
      };
    };
  };

  config = let
    cfg = config.glamdring.nixvim.dap;
    condition = cfg.enable;
  in mkIf condition {
      home.packages = with pkgs; if cfg.debuggers.gdb.enable
        then [ gdb ]
        else [];

      programs.nixvim = {
        extraPlugins = with pkgs.vimPlugins; [
          nvim-dap
          nvim-dap-ui
        ];

        plugins = {
          dap = {
            enable = true;
            extensions = {
              dap-ui.enable = true;
              dap-go.enable = true;
              dap-python.enable = true;

              dap-virtual-text.enable = cfg.virtualText;
            };

            adapters.executables = {
              gdb = mkIf cfg.debuggers.gdb.enable {
                command = "gdb";
                args = [ "-i" "dap" ];
              };
            };
          };
        };
      };
    };
}
