{ config, pkgs, lib, ... }:
{
  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    options = {
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

    globals.mapleader = ",";
    maps = let
      mkSilent = cmd: { silent = true; action = mkCmd cmd; };
      mkCmd = cmd: "<cmd>${cmd}<cr>";
    in {
      normal = {
        # Telescope
        "<leader>d<space>" = mkSilent "Telescope find_files";
        "<leader>g<space>" = mkSilent "Telescope live_grep";
        "<leader>b<space>" = mkSilent "Telescope buffers";
        "<leader>h<space>" = mkSilent "Telescope help_tags";
        # Neo-tree
        "<leader>d<leader>" = mkSilent "NeoTreeReveal";
        # Tabular
        "<leader>t<leader>" = "yl<ESC>:Tab/<C-R>\"<CR>"; # Align on character under cursor.
        # Convenience
        "Y" = "y$";        # Make Y consistent with D, C
        "<C-S>" = "<C-A>"; # C-A is used by tmux  
      };
      command = {
        # Exiting is case insensitive.
        "W" = "w"; "Wq" = "wq"; "Q" = "q"; "WQ" = "wq";
      };
      visual = {
        # git blame
        "<leader>gb<space>" = mkCmd "TODO";
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      # vim-colorschemes 
      neogit
      nvim-dap
      nvim-dap-ui
#      illuminate
      neotest
      tabular
      plenary-nvim
    ];

    colorschemes.gruvbox = {
      enable = true;
      contrastDark = "hard";
      trueColor = true;
    };

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      indent-blankline.enable = true;
      trouble.enable = true; 
      neo-tree.enable = true;
      todo-comments.enable = true;
      nvim-cmp.enable = true;
      nix.enable = true;
    };
  };
}
