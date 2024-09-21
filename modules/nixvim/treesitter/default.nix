{ config, lib, pkgs, vimUtils, ... }: {
  config = lib.mkIf config.glamdring.nixvim.enable {
    programs.nixvim.plugins.treesitter = {
      enable = true;
      languageRegister = {
        octo = "markdown";
      };
      settings = {
        highlight.enable = true;
      };
    };
  };
}
