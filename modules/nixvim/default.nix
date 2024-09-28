{ config, pkgs, lib, stylix, ... }: with lib; {
  options.glamdring.nixvim = {
    enable = mkEnableOption "Enable nixvim";
  };

  imports = [
    ./agrolens
    ./cmp
    ./colorscheme
    ./copilot
    ./coverage
    ./dap
    ./editor
    ./keybinds
    ./lsp
    ./neo
    ./statusline
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

      plugins = {
        # Still to do:
        # - nvim-dap
        #   - setup
        #     - rust (covers c/c++ too, based on the docs
        #     - ruby
        #     - nix?
        #     - ansible
        #     - python
        #     - go
        # - Copilot -> Local hosted migration
        # - ai chat + completion (maybe via cmp?)
        # - nvim-surround
        # - cursorless/talon setup?
        #   - probably for want of a lav mic.
        # - A rest client
        #   - https://github.com/rest-nvim/rest.nvim
        #   - https://github.com/mistweaverco/kulala.nvim
        #   - ideally something that works with hurl?
        # - agrolens
        #   - set up, but needs keybinds
        # - nvim-treesitter-textobjects
        # - nvim-coverage
        # - https://github.com/al1-ce/just.nvim
        # - https://github.com/tris203/precognition.nvim
        # - neogen? (to generate annotations quickly)
        # - some kind of session manager:
        #   - https://github.com/olimorris/persisted.nvim
        #   - https://github.com/gennaro-tedesco/nvim-possession
        # - DB client:
        #   - DadBod + DadBodUI, supports everything I want.
    };
  };
};
}
