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
      home.packages = with pkgs; [
        rust-analyzer
        vscode-extensions.vadimcn.vscode-lldb.adapter
      ];

      glamdring.nixvim.dap = {
        enable = cfg.debugger.enable;
      };

      programs.nixvim.plugins = {
        dap = {
          adapters.executables = {
            codellb = {
              command = "codelldb";
            };
          };
        };

        rustaceanvim = {
          enable = true;

          settings = {
            server = {
              cmd = [
                "rust-analyzer"
              ];
              default_settings = {
                rust-analyzer = {
                  check = {
                    command = "clippy";
                  };
                  inlayHints = {
                    lifetimeElisionHints = {
                      enable = "always";
                    };
                  };
                  completions = {
                    autoimport.enable = true;
                    autoself.enable = true;
                    fullFunctionSignatures = true;
                    snippets = {
                      "Arc::new" = {
                        body = "Arc::new(\${receiver})";
                        description = "Put the expression into an `Arc`";
                        postfix = "arc";
                        requires = "std::sync::Arc";
                        scope = "expr";
                      };
                      "Box::pin" = {
                        body = "Box::pin(\${receiver})";
                        description = "Put the expression into a pinned `Box`";
                        postfix = "pinbox";
                        requires = "std::boxed::Box";
                        scope = "expr";
                      };
                      Err = {
                        body = "Err(\${receiver})";
                        description = "Wrap the expression in a `Result::Err`";
                        postfix = "err";
                        scope = "expr";
                      };
                      Ok = {
                        body = "Ok(\${receiver})";
                        description = "Wrap the expression in a `Result::Ok`";
                        postfix = "ok";
                        scope = "expr";
                      };
                      "Rc::new" = {
                        body = "Rc::new(\${receiver})";
                        description = "Put the expression into an `Rc`";
                        postfix = "rc";
                        requires = "std::rc::Rc";
                        scope = "expr";
                      };
                      Some = {
                        body = "Some(\${receiver})";
                        description = "Wrap the expression in an `Option::Some`";
                        postfix = "some";
                        scope = "expr";
                      };
                    };
                  };
                  diagnostics.styleLints.enable = true;
                  hover = {
                    actions = {
                      enable = true;
                      debug.enable = true;
                      gotoTypeDef.enable = true;
                      implementations.enable = true;
                      references.enable = true;
                      run.enable = true;
                    };
                    documentation = {
                      enable = true;
                    };
                    imports = {
                      prefix = "crate";
                      merge.glob = true;
                    };
                    inlayHints = {
                      closureStyle = "rust_analyzer";
                    };
                    joinLines = {
                      joinAssignments = true;
                      joinElseIf = true;
                      removeTrailingComma = true;
                      unwrapTrivialBlock = true;
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
}
