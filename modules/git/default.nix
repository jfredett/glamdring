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
    programs.git = {
      enable = true;
      userName = cfg.identity.name;
      userEmail = cfg.identity.email;

      aliases = {
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

      difftastic = {
        # BUG: Justfiles don't seem to be supported right now?
        enable = false;
        color = "always";
      };

      diff-so-fancy = {
        enable = true;
      };


      extraConfig = {
        diff.algorithm = "patience";
        rerere.enabled = true;
        push.default = "current";
        init.defaultBranch = "main";
        color = {
          status = "auto";
          branch = "auto";
          interactive = "auto";
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

    home.shellAliases = {
      gru   = "git remote update -p";
      grom  = "git rebase origin/main";
      wip   = "git add -A . ; git ci -a -m 'wip'";
      unwip = "git reset HEAD^";
    };
  };
}
