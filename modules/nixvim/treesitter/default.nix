{ config, lib, pkgs, vimUtils, ... }: {
  config = lib.mkIf config.glamdring.nixvim.enable {
    programs.nixvim = {
      extraConfigLua = ''
        vim.o.foldlevel = 99
      '';
      
      plugins = {
        treesitter = {
          enable = true;
          folding = true;
          languageRegister = {
            markdown = "octo";
          };
          settings = {
            auto_install = true;
            ensure_installed = "all";
            highlight.enable = true;
            indent.enable = true;
          };
        };
        treesitter-textobjects = {
          enable = true;
        };
      };
    };
  };
}
