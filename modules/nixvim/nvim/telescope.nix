{ config, lib, pkgs, vimUtils, ... }: {
  programs.nixvim.plugins.telescope = {
    extensions = {
      frecency.enable = true;
    };
  };
}
