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
          # - nvim-surround
          # - nvim-dap
          #   - setup
          #     - rust (covers c/c++ too, based on the docs
          #     - ruby
          #     - nix?
          #     - ansible
          #     - python
          #     - go
          # - DB client:
          #   - DadBod + DadBodUI, supports everything I want.
          # - nvim-cmp
          #   - Copilot -> Local hosted migration
          #   - ai chat + completion (maybe via cmp?)
          #   - this is broadly set up, but the nvim-ai stuff is broken pending either getting my OPENAI key sorted, or
          #     moving to a local impl
          #   - I still want to get away from the direct copilot integration, but I think this is steady state for now.
          # - A rest client
          #   - https://github.com/rest-nvim/rest.nvim
          #   - https://github.com/mistweaverco/kulala.nvim
          #   - ideally something that works with hurl?
          # - agrolens
          #   - set up, but needs keybinds, tbh not sure this is going to be the way to go? I really think I might be
          #     stuck DIYing something to get the data I want (A breakdown of every file, every
          #     function/struct/trait/whatever in that file. and a quick way to jump to it, a la the vscode outliner)
          # - https://github.com/al1-ce/just.nvim
          # - https://github.com/tris203/precognition.nvim
          # - neogen? (to generate annotations quickly)
          # - some kind of session manager:
          #   - https://github.com/olimorris/persisted.nvim
          #   - https://github.com/gennaro-tedesco/nvim-possession
          # - cursorless/talon setup?
          #   - probably for want of a lav mic.
    };
  };
};
}
