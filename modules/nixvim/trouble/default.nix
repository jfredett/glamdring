{ config, lib, pkgs, vimUtils, ... }: {
  config = lib.mkIf config.glamdring.nixvim.enable {
    programs.nixvim = {
      plugins.trouble = {
        enable = true;


      };
    };
  };
}
