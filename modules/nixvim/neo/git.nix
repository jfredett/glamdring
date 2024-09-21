{ config, lib, pkgs, ... }: with lib; {
  config = let
    # This maybe should be overridable? But for the moment if I have git and vim, I probably want
    # this on, so no sense adding an option that will never be used.
    condition = config.glamdring.git.enable;
  in mkIf condition {
    home.packages = [ pkgs.gh ];

    programs.nixvim = {
      # https://github.com/topaxi/gh-actions.nvim <-- may be needed if octo can't do this?

      extraPlugins = with pkgs.vimPlugins; [
        neogit
      ];

      plugins = {
        neogit = {
          enable = true;
          settings = {
            commit_editor = {
              kind = "tab";
            };
            integrations = {
              telescope = true;
              diffview = true;
            };
          };
        };
        octo = {
          enable = true;
          settings = {
            enable_builtin = true;
            default_remote = ["origin"];
            ssh_aliases = {
              "github.work" = "github.com";
              "github.oz" = "github.com";
            };
          };
        };
        gitgutter.enable = true;
        gitblame = {
          enable = true;
          settings = {
            message_when_not_commited = "New";
            virtual_text_column = 125;
          };
        };
        diffview.enable = true;
      };
    };
  };
}
