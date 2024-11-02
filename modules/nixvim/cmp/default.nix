{ config, lib, pkgs, ... }: with lib; {
  options = with types; {
    glamdring.nixvim.cmp = {
      enable = mkEnableOption "Enable the module";
      ai = {
        enable = mkEnableOption "Enable cmp-ai";

      };
    };
  };

  config = let
    cfg = config.glamdring.nixvim.cmp;
    condition = cfg.enable;
  in mkIf condition {
      programs.nixvim = {
        extraConfigLuaPre = ''
          -- Disable arrow keys in specific modes
          vim.keymap.set({'n', 'i', 'v', 's', 'o'}, '<Up>', '<Nop>')
          vim.keymap.set({'n', 'i', 'v', 's', 'o'}, '<Down>', '<Nop>')
          vim.keymap.set({'n', 'i', 'v', 's', 'o'}, '<Left>', '<Nop>')
          vim.keymap.set({'n', 'i', 'v', 's', 'o'}, '<Right>', '<Nop>')
        '';

        plugins = {
          cmp = {
            enable = true;
            autoEnableSources = true;
            settings = {
              sources = [
                { name = "nvim_lsp"; }
                { name = "treesitter"; }
                { name = "path"; }
                { name = "buffer"; }
                { name = "calc"; }
                # { name = "spell"; }
                # { name = "tags"; }
                # { name = "cmp_ai"; }  #FIXME: this should be conditional / have it's dep inverted via module.
              ];
              mapping = {
                "<C-k>" = "cmp.mapping.complete()";
                "<C-d>" = "cmp.mapping.scroll_docs(-4)";
                "<Left>" = "cmp.mapping.close()";
                "<C-f>" = "cmp.mapping.scroll_docs(4)";
                "<Right>" = "cmp.mapping.confirm({ select = true })";
                "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
                "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              };
            };
          };

          cmp-ai = mkIf cfg.ai.enable {
            ## FIXME: This I think is causing some kind of bug, getting required despite the mkIf.
            enable = false;
            settings = {
              provider = "OpenAI";
              provider_options = {
                model = "o1-preview";
              };
              ignored_file_types = {
                "markdown" = true;
                "html" = true;
              };
            };
          };
        };
      };
    };
}
