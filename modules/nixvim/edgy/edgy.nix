{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.edgy = {
      enable = mkOption {
        type = types.bool;
        description = "Enable edgy";
        default = true;
      };
    };
  };

  config = let
    cfg = config.glamdring.nixvim.edgy;
    condition = cfg.enable;
  in mkIf condition {

      programs.nixvim = {
        autoCmd = let
          onStart = command: {
            inherit command;
            event = [
              "VimEnter"
            ];
          };

        in [
          (onStart ''lua require("edgy").open("left")'')
          (onStart ''lua require("edgy").open("right")'')

        ];


        plugins = {
          edgy = {
            enable = true;
            luaConfig.pre = builtins.readFile ./pre.lua;
            luaConfig.post = builtins.readFile ./post.lua;
          };
        };
      };
    };
}
