{ config, lib, pkgs, vimUtils, ... }: {
  programs.nixvim = {
    globals.mapleader = ",";

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
      # Neogit
      "<leader>g<leader>" = mkSilent "Neogit";
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
};
}
