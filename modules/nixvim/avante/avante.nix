{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.avante = {
      enable = mkEnableOption "Enable Avante";
      server = mkOption {
        type = types.str;
        default = "http://randy.emerald.city";
        description = "Avante Backend URL";
      };
      port = mkOption {
        type = types.int;
        default = 11434;
        description = "Avante Backend Port";
      };
    };
  };

  config = let
    cfg = config.glamdring.nixvim.avante;
    condition = cfg.enable;
  in mkIf condition {
      programs.nixvim = {
        plugins.avante = {
          enable = true;
          settings = {
            vendors = {
              qwen = {
                __inherited_from = "openai";
                endpoint = "${cfg.server}:${builtins.toString cfg.port}/v1";
                api_key_name = "";
                model = "qwen2-avante:latest";
                temperature = 0;
              };
            };
            diff = {
              autojump = true;
              debug = false;
              list_opener = "copen";
            };
            highlights = {
              diff = {
                current = "DiffText";
                incoming = "DiffAdd";
              };
            };
            hints = {
              enabled = true;
            };
            mappings = {
              diff = {
                both = "cb";
                next = "]x";
                none = "c0";
                ours = "co";
                prev = "[x";
                theirs = "ct";
              };
            };
            provider = "qwen";
            windows = {
              sidebar_header = {
                align = "center";
                rounded = true;
              };
              width = 30;
              wrap = true;
            };
          };
        };
      };
    };
}
