{ config, lib, pkgs, vimUtils, ... }: {

  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraConfig = ''
      """""" Settings """"""
      set nocompatible

      " Don't use swapfiles
      set nobackup
      set nowritebackup
      set noswapfile

      " Every way I've found to map a leaderkey.
      let mapleader = ","
      let maplocalleader = ","
      let g:C_MapLeader = ','

      "more bashy tab complete
      set wildmenu

      "reduce error message noise
      set shortmess=aIA

      " Inform me of random whitespace
      set list
      set listchars+=tab:\ \  "ignore tabs
      set listchars+=eol:\    "ignore eol's.
      set listchars+=trail:·
      set listchars+=extends:❯
      set listchars+=precedes:❮

      """""" Bindings """"""

      " Telescope
      nnoremap <leader>d<space> <cmd>Telescope find_files<cr>
      nnoremap <leader>g<space> <cmd>Telescope live_grep<cr>
      nnoremap <leader>b<space> <cmd>Telescope buffers<cr>
      nnoremap <leader>h<space> <cmd>Telescope help_tags<cr>
      
      " NERDTree
      nnoremap <leader>d<leader> :NERDTreeToggle<cr>

      " git blame
      vmap <leader>gb<space> :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

      " Make Y consistent with D, C
      nnoremap Y y$

      "I screw up alot
      command! W w
      command! Wq wq
      command! Q q
      command! WQ wq

      nmap  <leader>f<space> zf%

      "remap mark from ` to ', and vice versa, so we get the better behavior more
      "easily.
      nnoremap ' `
      nnoremap ` '

      " TODO Get the Tab plugin set back up
      " nmap <silent> <leader>t<space> yl<ESC>:Tab /"<CR>

      " TODO: Convert this to ripgrep
      " nmap <silent> <leader>a<space> :Ack '<cword>'<CR>

      nmap <silent> C :cnext<CR>
      nmap <silent> B :cprevious<CR>

      nmap <silent> <C-N> :bn<CR>
      nmap <silent> <C-P> :bp<CR>

      " Remap ^A -> ^S so it works in tmux
      noremap <C-S> <C-A>

    '';
    extraLuaConfig = ''
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    '';

    plugins = with pkgs.vimPlugins; [
      vim-nix           
      plenary-nvim
      tabular

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
          config = ''
          lua require('telescope').setup()
          '';
      }
      {
          plugin = indent-blankline-nvim;
          config = "lua require('indent_blankline').setup()";
      }
      {
          plugin = nvim-lspconfig;
          config = ''
          lua << EOF
            local lspconfig = require('lspconfig')
            local configs = require('lspconfig.configs')
            local util = require('lspconfig.util')

            lspconfig.rust_analyzer.setup{}
            lspconfig.lua_ls.setup{}

            if not configs.ruby_lsp then
              configs.ruby_lsp = {
                default_config = {
                  cmd = { "bundle", "exec", "ruby-lsp", },
                  filetypes = { "ruby", },
                  root_dir = util.root_pattern("Gemfile", ".git"),
                  init_options = {
                    enabledFeatures = {
                      "documentHighlights", "documentSymbols", "foldingRanges", "selectionRanges",
                      "formatting", "codeActions",
                    },
                  },
                  settings = {},
                },
                commands = {
                  FormatRuby = {
                    function()
                      vim.lsp.buf.format({
                        name = "ruby_lsp",
                        async = true,
                      })
                    end,
                    description = "Format buffer with Ruby LSP",
                  },
                },
              }
            end

            lspconfig.ruby_ls.setup{}
          EOF
          '';
      }
      {
          plugin = nvim-treesitter.withAllGrammars;
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
      {
          plugin = trouble-nvim;
          config = ''
          lua << EOF
            require("trouble").setup {

            }
          EOF
          '';
      }

      nerdtree
      nerdtree-git-plugin


      {
          plugin = neogit;
          config = ''
          '';
      }
      {
          plugin = nvim-dap;
          config = ''
          '';
      }
      # nvim-dap-ui
      # todo-comments
      # illuminate
      # neotest
      # nvim-cmp
    ];
  };
}

