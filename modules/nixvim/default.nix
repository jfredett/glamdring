{ config, pkgs, lib, ... }: with lib; {
  options.glamdring.nixvim = {
    enable = mkEnableOption "Enable nixvim";
    colorscheme = mkOption {
      type = types.str;
      default = "gruvbox";
      description = ''
        The colorscheme to use.
      '';
    };
    copilot = mkEnableOption "Enable copilot";
  };

  imports = [
    ./nvim/lsp.nix
    ./nvim/neotest.nix
    ./nvim/options.nix
    ./nvim/telescope.nix
    ./nvim/treesitter.nix
  ];

  config = let
    cfg = config.glamdring.nixvim;
  in mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      viAlias = true;
      vimAlias = true;

      colorschemes = {
        gruvbox = mkIf (cfg.colorscheme == "gruvbox") {
          enable = true;
          settings = {
            contrastDark = "hard";
            italics = 1;
            bold = 1;
            term_colors = 256;
            trueColor = true;
          };
        };
        kanagawa = mkIf (cfg.colorscheme == "kanagawa") {
          enable = true;
          settings = {
            colors = {
              theme = {
                all = {
                  bg_gutter = "none";
                };
              };
            };
            commentStyle = {
              italic = true;
            };
            compile = false;
            dimInactive = false;
            functionStyle = { };
            terminalColors = true;
            # FIXME: this doesn't seem to be working.
            theme = "dragon";
            transparent = false;
            undercurl = true;
          };
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
        # illuminate TODO: Figure out how to import a git plugin that isn't prior packaged.
        neogit
        nvim-dap
        nvim-dap-ui
        neotest
        tabular
        plenary-nvim
      ] ++ (if cfg.copilot then [ copilot-vim ] else []);

      plugins = {
        commentary.enable = true;
        indent-blankline.enable = true;
        lsp.enable = true;
        lualine.enable = true;
        neo-tree = {
          enable = true;
          sortCaseInsensitive = true;
          filesystem.filteredItems.hideGitignored = false;
        };
        dap.enable = true;
        neotest.enable = true;


        neogit = {
          enable = true;
          settings = {
            commit_editor = {
              kind = "tab";
            };
          };
        };
        # TODO: get this set up
        # octo.enable = true;
        gitgutter.enable = true;
        gitblame = {
          enable = true;
          settings = {
            message_when_not_commited = "New";
            virtual_text_column = 125;
          };
        };
        diffview.enable = true;

        toggleterm = {
          enable = true;
          settings = {
            open_mapping = "[[<leader><space><leader>]]";
          };
        };

        nix.enable = true;
        cmp.enable = true;
        telescope = {
          enable = true;
          settings = {
            pickers = {
              find_files = {
                no_ignore = true;
              };
            };
          };
        };
        todo-comments.enable = true;
        treesitter.enable = true;
        trouble.enable = true;
      };
    };
  };
}
