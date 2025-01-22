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
    };
  };

  config = let
    cfg = config.glamdring.nixvim.avante;
    condition = cfg.enable;
  in mkIf condition {
      programs.nixvim = {
        plugins.codecompanion = {
          enable = true;

          settings = {
            adapters = {
              __raw = /* lua */ ''
                function()
                  return require('codecompanion.adapters').extend('ollama', {
                  env = {
                  url = "${cfg.server}:${builtins.toString cfg.port}/v1";
                    },
                    schema = {
                      model = {
                        default = "qwen2-avante:latest",
                      },
                      num_ctx = {
                        default = 32768,
                      },
                    },
                  })
                end
              '';
            };
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
}
