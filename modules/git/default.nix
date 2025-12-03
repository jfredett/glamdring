{ config, lib, pkgs, ... }: {
  options = with lib; with types; {
    glamdring.git = {
      enable = mkEnableOption "glamdring-git";
      identity = mkOption {
        type = submodule {
          options = {
            name = mkOption { type = str; };
            email = mkOption { type = str; };
          };
        };
      };
    };
  };

  config = let 
    cfg = config.glamdring.git;
  in lib.mkIf cfg.enable {
      programs = {
        # difftastic = {
        #   # BUG: Justfiles don't seem to be supported right now?
        #   enable = false;
        #   color = "always";
        # };

        diff-so-fancy = {
          enable = true;
        };

        git = {
          enable = true;
          settings = {
            user = cfg.identity;
            diff.algorithm = "patience";
            credential = {
              helper = "cache --timeout=3600";
            };
            rerere.enabled = true;
            push.default = "current";
            init.defaultBranch = "main";
            color = {
              status = "auto";
              branch = "auto";
              interactive = "auto";
            };
            alias = {
              co    = "checkout";
              st    = "status";
              ci    = "commit";
              w     = "whatchanged";
              core  = "shortlog -s -n --no-merges";
              rc    = "rebase --continue";
              abort = "rebase --abort";
              skip  = "rebase --skip";
              gr    = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
              patch = "commit --amend --no-edit";
            };
          };


          ignores = [
            ".direnv/"
            ".envrc"
            ".env"
            ".env.local"
            ".env.development"
            ".env.test"
            ".env.production"
            ".cache/"
            ".vscode/"
            ".idea/"
            ".DS_Store"
            "node_modules/"
            "yarn-error.log"
          ];
        };
      };

      home.shellAliases = {
        gru   = "git remote update -p";
        grom  = "git rebase origin/main";
        wip   = "git add -A . ; git ci -a -m 'wip'";
        unwip = "git reset HEAD^";
      };
    };
}
