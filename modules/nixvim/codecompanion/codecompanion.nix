{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.code-companion = {
      enable = mkEnableOption "Enable Code Companion";
      server = mkOption {
        type = types.str;
        default = "http://randy.emerald.city";
        description = "Backend URL";
      };
      port = mkOption {
        type = types.int;
        default = 11434;
        description = "Backend Port";
      };
      model = mkOption {
        type = types.str;
        default = "gooddog:latest";
        description = "name of the ollama model to use";
      };

      ctx_size = mkOption {
        type = types.int;
        default = 32768;
        description = "number of tokens to use for context";
      };
    };
  };

  config = let
    cfg = config.glamdring.nixvim.code-companion;
    condition = cfg.enable;
  in mkIf condition {
      # TODO: Prepare a Modelfile and optionally compile it for the target?

      programs.nixvim = {
        plugins.codecompanion = {
          enable = true;

          settings = {
            adapters = {
              ollama.__raw = /* lua */ ''
                function()
                  return require('codecompanion.adapters').extend('ollama', {
                    env = {
                      url = "${cfg.server}:${builtins.toString cfg.port}";
                    },
                    schema = {
                      model = {
                        default = "${cfg.model}";
                      },
                      num_ctx = {
                        default = ${builtins.toString cfg.ctx_size};
                      },
                    },
                    parameters = {
                      sync = true;
                    },
                  })
                end
                  '';
            };
            opts = {
              log_level = "TRACE";
              send_code = true;
              use_default_actions = true;
              use_default_prompts = true;
            };
            strategies = {
              agent = {
                adapter = "ollama";
              };
              chat = {
                adapter = "ollama";
              };
              inline = {
                adapter = "ollama";
              };
            };
          };
        };
      };
    };
}
