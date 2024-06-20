{ config, pkgs, lib, ... }:
{
  imports = [
    ./nvim/options.nix
    ./nvim/telescope.nix
    ./nvim/treesitter.nix
    ./nvim/lsp.nix
  ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    colorschemes.gruvbox = {
      enable = true;
      settings = {
        contrast_dark = "hard";
        true_color = true;
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
      neo-tree.enable = true;
      nix.enable = true;
      cmp.enable = true;
      telescope.enable = true;
      todo-comments.enable = true;
      treesitter.enable = true;
      trouble.enable = true; 
    };
  };
}
