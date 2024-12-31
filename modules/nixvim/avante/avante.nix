{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.avante = {
      enable = mkEnableOption "Enable Avante";
      server = mkOption {
        type = types.str;
        default = "http://randy.emerald.city";
        description = "Avante Backend URL";
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
                endpoint = cfg.server;
                max_tokens = 4096;
                model = "qwen2.5-coder:32b";
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
