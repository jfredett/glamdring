{ config, lib, pkgs, vimUtils, ... }:
let
  # installs a vim plugin from git with a given tag / branch
  # knicked from https://breuer.dev/blog/nixos-home-manager-neovim
  pluginGit = ref: repo: vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  # always installs latest version
  plugin = pluginGit "HEAD";
in {
  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      
      vim-nix           
      plenary-nvim

      {
          plugin = vim-colorschemes;    
          config = "colorscheme obsidian";
      }
      {
          plugin = impatient-nvim;
          config = "lua require('impatient')";
      }
      {
          plugin = lualine-nvim;
          config = "lua require('lualine').setup()";
      }
      {
          plugin = telescope-nvim;
          config = "lua require('telescope').setup()";
      }
      {
          plugin = indent-blankline-nvim;
          config = "lua require('indent_blankline').setup()";
      }
      {
          plugin = nvim-lspconfig;
          config = ''
            lua << EOF
            require('lspconfig').rust_analyzer.setup{}
            require('lspconfig').sumneko_lua.setup{}
            require('lspconfig').rnix.setup{}
            EOF
          '';
      }
      {
          plugin = nvim-treesitter;
          config = ''
          lua << EOF
          require('nvim-treesitter.configs').setup {
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            },
          }
          EOF
          '';
      }
    ];
  };
}
