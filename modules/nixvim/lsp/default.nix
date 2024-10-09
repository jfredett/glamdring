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
          lua_ls.enable = true;
          nginx_language_server.enable = true;
          nil_ls.enable = true;
          pylsp.enable = true;
          ruby_lsp.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };
    };
  };
}
