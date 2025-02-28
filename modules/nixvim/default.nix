{ config, pkgs, lib, stylix, ... }: with lib; {
  options.glamdring.nixvim = {
    enable = mkEnableOption "Enable nixvim";
  };

  imports = [
    ./agrolens
    ./cmp
    ./codecompanion
    ./colorscheme
    ./coverage
    ./dap
    ./editor
    ./image
    ./keybinds
    ./lsp
    ./neo
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

      plugins = {
          # Still to do:
          # - DB client:
          #   - DadBod + DadBodUI, supports everything I want.
          # - notify / some improved notification system
          # - nvim-cmp
          #   - Copilot -> Local hosted migration (Avante?)
          #   - ai chat + completion (maybe via cmp?)
          #   - this is broadly set up, but the nvim-ai stuff is broken pending either getting my OPENAI key sorted, or
          #     moving to a local impl
          #   - I still want to get away from the direct copilot integration, but I think this is steady state for now.
          # - A rest client
          #   - https://github.com/rest-nvim/rest.nvim
          #   - https://github.com/mistweaverco/kulala.nvim
          #   - ideally something that works with hurl?
          # - https://github.com/al1-ce/just.nvim
          # - neogen? (to generate annotations quickly)
          # - some kind of session manager:
          #   - https://github.com/olimorris/persisted.nvim
          #   - https://github.com/gennaro-tedesco/nvim-possession
          # - cursorless/talon setup?
          #   - probably for want of a lav mic.
          # - todo-comments https://github.com/folke/todo-comments.nvim <-- in nixvim
    };
  };
};
}
