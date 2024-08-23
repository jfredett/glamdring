{ config, lib, pkgs, vimUtils, ... }: {
  config = lib.mkIf config.glamdring.nixvim.enable {
    home.packages = with pkgs; [
      shellcheck
    ];

    programs.nixvim.plugins.lsp = {
      servers = {
        bashls.enable = true;
        cssls.enable = true;
        hls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        lua-ls.enable = true;
        pylsp.enable = true;
        ruby-lsp.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };
    };
  };
}
