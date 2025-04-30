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
          numbertoggle.enable = true;
          nvim-surround.enable = true;

          # TODO: Move these to their own module
          notify = {
            enable = true;
            settings = {
              top_down = true;
              max_height = 10;
              max_width = 80;
              minimum_width = 50;
              merge = true;
              timeout = 3000;
              render = "minimal";
              stages = "fade";
            };
          };
          noice = {
            settings = {
              notify.enabled = true;
              lsp.override = {
                "vim.lsp.util.convert_input_to_markdown_lines" = true;
                "vim.lsp.util.stylize_markdown" = true;
                "cmp.entry.get_documentation" = true;
              };
              presets = {
                bottom_search = true;
                command_palette = true;
                long_message_to_split = true;
                inc_rename = true;
                lsp_doc_border = true;
              };
              popupmenu = {
                enabled = true;
                backend = "cmp";
              };
              enable = true;
            };
          };
          ####



          # language enablement
          nix.enable = true;

          # dev icons
          web-devicons.enable = true;
        };

        # General options
        globals.mapleader = ",";
        opts = {
          number = true;
          relativenumber = true;
          cursorline = true;
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
