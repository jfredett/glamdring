{ config, lib, pkgs, vimUtils, ... }: {
  options = with lib; {
    glamdring.nixvim.lsp = {
      enable = mkEnableOption "Enable LSP";
    };
  };
  config = lib.mkIf config.glamdring.nixvim.lsp.enable {
    home.packages = with pkgs; [
      shellcheck
    ];

    programs.nixvim = {

      plugins.lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          cssls.enable = true;
          hls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          lua-ls.enable = true;
          nginx-language-server.enable = true;
          nil-ls.enable = true;
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
  };
}
