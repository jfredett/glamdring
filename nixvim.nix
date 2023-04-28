{ config, pkgs, lib, ... }:
{
  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    imports = [
      ./nvim/options.nix
    ];

    extraPlugins = with pkgs.vimPlugins; [
      # vim-colorschemes 
      neogit
      nvim-dap
      nvim-dap-ui
#      illuminate TODO: Figure out how to import a git plugin that isn't prior packaged.
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
