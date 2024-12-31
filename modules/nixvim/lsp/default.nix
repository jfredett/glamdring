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
          hls = {
            enable = true;
            installGhc = false;
          };
          html.enable = true;
          jsonls.enable = true;
          lua_ls.enable = true;
          nginx_language_server.enable = true;
          nil_ls.enable = true;
          pylsp.enable = true;
          # FIXME: broken on unstable 27-DEC-2024
          ruby_lsp.enable = false;
        };
      };
    };
  };
}
