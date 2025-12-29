{ config, pkgs, lib, stylix, ... }: with lib; {
  options.glamdring.nixvim = {
    enable = mkEnableOption "Enable nixvim";
  };

  imports = [
    ./agrolens
    ./cmp
    ./colorscheme
    ./coverage
    ./dap
    ./edgy
    ./editor
    ./image
    ./keybinds
    ./lean
    ./lsp
    ./modelica
    ./neo
    ./obsidian
    ./rust
    ./statusline
    ./stickybuf
    ./telescope
    ./terminal
    ./treesitter
    ./trouble
  ];

  config = let
    cfg = config.glamdring.nixvim;
  in mkIf cfg.enable {
      programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        package = pkgs.neovim;


        # Still to do:
        # - DB client:
        #   - DadBod + DadBodUI, supports everything I want.
        # - nvim-cmp
        # - A rest client
        #   - https://github.com/rest-nvim/rest.nvim
        #   - https://github.com/mistweaverco/kulala.nvim
        #   - ideally something that works with hurl?
        # - https://github.com/al1-ce/just.nvim
        # - neogen? (to generate annotations quickly)
        # - cursorless/talon setup?
        #   - probably for want of a lav mic.
      };
    };
}
