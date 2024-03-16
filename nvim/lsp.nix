{ config, lib, pkgs, vimUtils, ... }: {
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
      rust-analyzer.enable = true;
    };
  };
}
