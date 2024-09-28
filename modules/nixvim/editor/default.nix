# Various editor-level config and plugin setup that is too granular to place in it's own module.
#
# That is to say, a testament to my own laziness.
{ config, lib, pkgs, ... }: with lib; {
  config = let
    cfg = config.glamdring.nixvim;
    condition = cfg.enable;
  in mkIf condition {
      programs.nixvim = {
        # Config-free plugins (mod keybinds)
        extraPlugins = with pkgs.vimPlugins; [
          tabular
          plenary-nvim
          nvim-web-devicons
          vim-illuminate
        ];

        plugins = {
          auto-save.enable = true;
          commentary.enable = true;
          indent-blankline.enable = true;
          todo-comments.enable = true;
          # language enablement
          nix.enable = true;
        };

        # General options
        globals.mapleader = ",";
        opts = {
          number = true;
          relativenumber = false;
          incsearch = true;
          backup = false;
          writebackup = false;
          swapfile = false;
          wildmenu = true;
          shortmess = "aIA";
          # Show loose whitespace
          list = true;

          expandtab = true;
          shiftwidth = 4;
          tabstop = 4;

          textwidth = 120;
        };
      };
    };
}
