{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.rust = {
      enable = mkEnableOption "Enable the module";
      debugger = {
        enable = mkEnableOption "Enable the debugger";
        using = mkOption {
          type = types.enum [ "lldb" "codelldb" ];
          default = "codelldb";
          description = "The debugger to use";
        };
      };
    };

  };

  config = let
    cfg = config.glamdring.nixvim.rust;
    condition = cfg.enable;
  in mkIf condition {
      # home.packages = with pkgs; if (cfg.debugger == "codelldb")
      #   then [ vscode-extensions.vadimcn.vscode-lldb.adapter ]
      #   else [ lldb ];
      home.packages = with pkgs; [ vscode-extensions.vadimcn.vscode-lldb.adapter ];

      glamdring.nixvim.dap = {
        enable = cfg.debugger.enable;
      };


      programs.nixvim.plugins = {
        dap = {
          adapters.executables = {
            codellb = {
              command = "codelldb";
            };

            # lldb = mkIf (cfg.debugger.using == "lldb") {
            #   command = "lldb-dap";
            # };
          };
        };

        rustaceanvim = {
          enable = true;

          # settings = {
          #   server = {
          #     cmd = [
          #       "rustup"
          #       "run"
          #       "nightly"
          #       "rust-analyzer"
          #     ];
          #     default_settings = {
          #       rust-analyzer = {
          #         check = {
          #           command = "clippy";
          #         };
          #         inlayHints = {
          #           lifetimeElisionHints = {
          #             enable = "always";
          #           };
          #         };
          #       };
          #     };
          #     standalone = false;
          #   };
          # };
        };
      };
    };
}
