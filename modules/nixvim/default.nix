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
  };

  imports = [
    ./nvim/options.nix
    ./nvim/telescope.nix
    ./nvim/treesitter.nix
    ./nvim/lsp.nix
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
        copilot-vim
      ];

      plugins = {
        indent-blankline.enable = true;
        lsp.enable = true;
        lualine.enable = true;
        neo-tree = {
          enable = true;
          sortCaseInsensitive = true;
          filesystem.filteredItems.hideGitignored = false;
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
