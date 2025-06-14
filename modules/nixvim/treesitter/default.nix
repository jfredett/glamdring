{ config, lib, pkgs, vimUtils, ... }: {
  config = lib.mkIf config.glamdring.nixvim.enable {
    programs.nixvim = {
      extraConfigLua = ''
        vim.o.foldlevel = 99
      '';

      # TODO: Precompile all grammars and link where nvim expects them (or correct the setting elsewise)
      plugins = {
        treesitter = {
          enable = true;
          folding = false;
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
