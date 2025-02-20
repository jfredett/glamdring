{ config, lib, pkgs, ... }: with lib; {

  options = with types; {
    glamdring.nixvim.neo.git = {
      gutter = {
        enable = mkEnableOption "Enable the gitgutter plugin | WARNING: May be a performance hog.";
      };
    };
  };

  config = let
    # This maybe should be overridable? But for the moment if I have git and vim, I probably want
    # this on, so no sense adding an option that will never be used.
    condition = config.glamdring.git.enable;
    enableGutter = config.glamdring.nixvim.neo.git.gutter.enable;
  in mkIf condition {
      home.packages = [ pkgs.gh ];

      programs.nixvim = {
        # https://github.com/topaxi/gh-actions.nvim <-- may be needed if octo can't do this?

        extraPlugins = with pkgs.vimPlugins; [
          neogit
        ];

        # Set update time to once-per-minute instead of once-every-four-seconds. Hopefully reduces perf impact of
        # gitgutter.
        extraFiles =  mkIf enableGutter {
          "gitgutter-conf.lua" = {
            text = ''
              vim.g.updatetime = 10000
            '';
            enable = true;
          };
        };

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
          gitgutter = {
            enable = enableGutter;
          };
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
