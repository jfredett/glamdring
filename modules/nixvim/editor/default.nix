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

        # 2 spaces is more than enough for a tab, and never use \t.
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;

        # 3x100 = 15 characters shy of a max width 1440p screen for me.
        # which means exactly 3 columns of text before wrapping.
        textwidth = 100;
      };
    };
  };
}
