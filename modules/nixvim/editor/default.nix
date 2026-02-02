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

        autoCmd = [
          # ensure helm lsp is used for helm.
          { event = "FileType"; pattern = "helm"; command = "LspRestart"; }
        ]

        plugins = {
          auto-save.enable = true;
          commentary.enable = true;
          indent-blankline.enable = true;
          todo-comments.enable = true;
          helm.enable = true;
          numbertoggle.enable = true;
          nvim-surround.enable = true;

          # TODO: Move these to their own module
          notify = {
            enable = true;
            settings = {
              top_down = true;
              max_height = {
                __raw = /* lua */ ''
                  function()
                    return math.floor(vim.o.columns * 0.6)
                  end
                '';
              };
              max_width = {
                __raw = /* lua */ ''
                  function()
                    return math.floor(vim.o.lines * 0.6)
                  end
                '';
              };
              minimum_width = 50;
              merge = true;
              timeout = 5000;
              render = "wrapped-compact";
              stages = "static";

              on_open = { __raw = /* lua */ ''
                function(win)
                  local cur_win = vim.api.nvim_get_current_win()
                  local win_pos = vim.api.nvim_win_get_position(cur_win)
                  local win_width = vim.api.nvim_win_get_width(cur_win)

                  local notif_width = vim.api.nvim_win_get_width(win)

                  vim.api.nvim_win_set_config(win, {
                    relative = "editor",
                    row = win_pos[1] + 1,
                    col = win_pos[2] + math.floor((win_width - notif_width) / 2),
                  })
                end
                '';
              };
            };
          };

          noice = {
            enable = false;
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
